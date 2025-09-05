# TODO：实现 SemanticAgent 类，继承 ChatModel 类，部署我们训练的批评模型，根据传入的 「prompt」 进行「批评」并返回结果。
from typing import *
import math

from src.utils.file_process import *
from src.agents.vllm_model import ChatModel


class SemanticAgent(ChatModel):
    def apply_template(self, messages: List[str]) -> List[str]:
        prompts = []
        for message in messages:
            templated_message = f"Human: {message}\nAssistant: "
            prompts.append(templated_message)

        return prompts
    
    def chat(self, prompt: str) -> List[Dict[str, any]]:
        prompts = [prompt for _ in range(self.sampling_times)]
        input_texts = self.apply_template(prompts)

        generate_results = self.llm.generate(input_texts, self.sampling_params)

        outputs = []
        for i, output in enumerate(generate_results):
            prompt = output.prompt
            prompt_token_ids = output.prompt_token_ids
            prompt_length = len(prompt_token_ids)

            generated_text = output.outputs[0].text.strip()
            generated_token_ids = output.outputs[0].token_ids
            generated_length = len(generated_token_ids)
            stop_reason = "Reached max_tokens" if len(output.outputs[0].token_ids) >= self.max_tokens else "Stopped by <EOS>"

            logprobs = output.outputs[0].logprobs
            total_logprob = sum(logprob[token_id].logprob for token_id, logprob in zip(output.outputs[0].token_ids, logprobs))
            confidence = math.exp(total_logprob / len(logprobs))

            outputs.append({
                "prompt": prompt,
                "prompt_length": prompt_length,
                "generated_text": generated_text,
                "generated_length": generated_length,
                "stop_reason": stop_reason,
                "confidence": confidence,
            })
        
        return outputs


# if __name__=='__main__':
#     chat_model = SemanticAgent("/data/ganleilei/cjk/tool_sql_agent/base_models/Qwen2-7B-Instruct")
#     print(chat_model.chat("八嘎呀路！"))