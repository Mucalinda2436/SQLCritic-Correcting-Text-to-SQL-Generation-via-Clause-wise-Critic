from vllm import LLM, SamplingParams
from typing import *
import math

from src.utils.file_process import *


class ChatModel:
    def __init__(self, model_name_or_path: str, stop_words: List[str]=[], temperature: float=0.0, sampling_times: int=1, max_tokens: int=1024, vllm_gpu_util: float=0.8, seed: Optional[int]=None) -> None:
        self.stop_words = stop_words
        self.temperature = temperature
        self.max_tokens = max_tokens
        self.sampling_times = sampling_times
        self.seed = seed
        self.vllm_gpu_util = vllm_gpu_util
        self.llm = LLM(
            model=model_name_or_path,
            tensor_parallel_size=1,  # 使用的 GPU 数量
            seed=42,  # 用于采样的随机数生成器的种子，保证生成结果的可重复性
            gpu_memory_utilization=self.vllm_gpu_util,  # 用于指定 GPU 内存的使用比例（0 到 1 之间），用于模型权重、激活以及 KV 缓存。更高的值会提高 KV 缓存的大小，从而提升模型吞吐量，但过高的值可能会导致内存不足（OOM）错误
            trust_remote_code=True,
            max_model_len=9216  # 模型的最大生成长度，包含prompt长度和generated长度。
        )
        self.sampling_params = SamplingParams(n=1, presence_penalty=0.0, frequency_penalty=0.0, repetition_penalty=1.0, temperature=self.temperature, top_p=0.8, top_k=50, min_p=0.0, seed=self.seed, stop=self.stop_words, stop_token_ids=[], bad_words=[], include_stop_str_in_output=False, ignore_eos=False, max_tokens=self.max_tokens, min_tokens=0, logprobs=1, prompt_logprobs=None, skip_special_tokens=True, spaces_between_special_tokens=True, truncate_prompt_tokens=None, guided_decoding=None)

    def apply_template(self, messages: List[Dict[str, str]]) -> str:
        templated_prompt = ""
        for message in messages:
            if message['role'] == 'system' and message['content'] != "":
                templated_prompt = templated_prompt + message['content'] + '\n'
            elif message['role'] == 'user':
                templated_prompt = templated_prompt + 'Human: ' + message['content'] + '\n'
            elif message['role'] == 'assistant':
                templated_prompt = templated_prompt + 'Assistant: ' + message['content'] + '<s>\n'

        return templated_prompt + 'Assistant: '
    
    def template_prompts(self, prompts: List[List[Dict[str, str]]]) -> List[str]:
        templated_prompts =  []
        for prompt in prompts:            
            templated_prompt = self.apply_template(prompt)
            templated_prompts.append(templated_prompt)
               
        return templated_prompts

    def chat(self, prompts: List[List[Dict[str, str]]]) -> List[Dict[str, any]]:
        # 按照 sampling_times 扩充样本
        prompts = [item for item in prompts for _ in range(self.sampling_times)]
        # 获取格式化后的输入
        input_texts = self.template_prompts(prompts)
        # 记录样本的 id 标签
        sample_ids = [i // self.sampling_times for i in range(len(input_texts))]

        # 使用 vLLM 的生成方法
        generate_results = self.llm.generate(input_texts, self.sampling_params)

        outputs = []
        # 遍历每条结果，计算 输出文本、confidence 等
        for i, output in enumerate(generate_results):
            prompt = output.prompt  # 当前输入文本
            # 计算 prompt 的长度
            prompt_token_ids = output.prompt_token_ids
            prompt_length = len(prompt_token_ids)

            generated_text = output.outputs[0].text.strip()  # 解码生成的文本
            # 计算生成文本的长度
            generated_token_ids = output.outputs[0].token_ids
            generated_length = len(generated_token_ids)
            # 计算停止原因
            stop_reason = "Reached max_tokens" if len(output.outputs[0].token_ids) >= self.max_tokens else "Stopped by <EOS>"

            # 计算整个回答的confidence
            logprobs = output.outputs[0].logprobs
            total_logprob = sum(logprob[token_id].logprob for token_id, logprob in zip(output.outputs[0].token_ids, logprobs))
            confidence = math.exp(total_logprob / len(logprobs))  # 计算平均log概率的指数

            outputs.append({
                "id": sample_ids[i],
                "prompt": prompt,
                "prompt_length": prompt_length,
                "generated_text": generated_text,
                "generated_length": generated_length,
                "stop_reason": stop_reason,
                "confidence": confidence,
            })

        return outputs


# def load_config_from_yaml(yaml_file: str) -> Dict:
#     """读取并解析 YAML 配置文件"""
#     with open(yaml_file, 'r', encoding='utf-8') as file:
#         config = yaml.safe_load(file)
#     return config


# if __name__=='__main__':
#     # 解析命令行参数
#     parser = argparse.ArgumentParser(description="Chat model inference")
#     parser.add_argument('config_file', type=str, help="Path to the config YAML file")
#     args = parser.parse_args()

#     # 加载配置
#     config = load_config_from_yaml("config.yaml")

#     # 动态构建初始化参数，检查配置文件是否包含相应的键
#     model_name_or_path = config['model_name_or_path']
#     data_path = config['data_path']
#     save_root = config['save_root']
#     output_file_name = config['output_file_name']
#     temperature = config.get('temperature', 0.0)  # 默认温度为 0.0
#     sampling_times = config.get('sampling_times', 1)  # 默认采样次数为 1
#     max_tokens = config.get('max_tokens', 512)  # 默认最大生成长度为 512
#     stop_words = config.get('stop_words', [])  # 默认无停止词
#     vllm_gpu_util = config.get('vllm_gpu_util', 0.6)
#     seed = config.get('seed', None)
    
#     # 创建 ChatModel 实例
#     chat_model = ChatModel(
#         model_name_path=model_name_or_path,
#         stop_words=stop_words,
#         temperature=temperature,
#         sampling_times=sampling_times,
#         max_tokens=max_tokens,
#         vllm_gpu_util=vllm_gpu_util,
#         seed=seed
#     )

#     # 加载 prompts
#     prompts = load_json(data_path)

#     # 推理
#     outputs = chat_model.chat(prompts)

#     # 保存
#     save_path = os.path.join(save_root, output_file_name)
#     dump_json(outputs, save_path)