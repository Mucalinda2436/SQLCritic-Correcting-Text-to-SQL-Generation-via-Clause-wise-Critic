from transformers import AutoTokenizer


class LLM:
    # openai LLMs
    # GPT_35_TURBO = "gpt-3.5-turbo"
    GPT_35_TURBO = "gpt-3.5-turbo"
    GPT_4o = "gpt-4o"
    GPT_4o_0806 = "Xenova/gpt-3.5-turbo"
    GPT_4o_mini = "gpt-4o-mini"
    GPT_4_TURBO = "gpt-4-turbo"

    # LLMs that use openai chat api
    TASK_CHAT = [
        GPT_35_TURBO,
        GPT_4o,
        GPT_4o_0806,
        GPT_4o_mini,
        GPT_4_TURBO
    ]

    # Input: $ price / 1000 tokens
    intput_costs_per_thousand = {
        GPT_35_TURBO: 0.0005,
        GPT_4o: 0.005,
        GPT_4o_0806: 0.0025,
        GPT_4o_mini: 0.00015,
        GPT_4_TURBO: 0.01
    }

    # Output: $ price / 1000 tokens
    output_costs_per_thousand = {
        GPT_35_TURBO: 0.0005 * 3,
        GPT_4o: 0.005 * 3,
        GPT_4o_0806: 0.0025 * 4,
        GPT_4o_mini: 0.00015 * 4,
        GPT_4_TURBO: 0.01 * 3
    }

    # local LLMs
    LLAMA_7B = "llama-7b"
    ALPACA_7B = "alpaca-7b"


def cost_estimate(n_tokens: int, model_name: str, mode: str):
    if mode == 'input':
        return LLM.intput_costs_per_thousand[model_name] * n_tokens / 1000
    elif mode == 'output':
        return LLM.output_costs_per_thousand[model_name] * n_tokens / 1000
    else:
        raise ValueError(f"Invalid mode: {mode}. Expected 'input' or 'output'.")


def get_tokenizer(tokenizer_type: str):
    tokenizer = AutoTokenizer.from_pretrained(tokenizer_type, use_fast=False)
    return tokenizer


def count_tokens(string: str, tokenizer_type: str=None, tokenizer=None):
    if tokenizer is None:
        tokenizer = get_tokenizer(tokenizer_type)
    
    n_tokens = len(tokenizer.encode(string))
    return n_tokens