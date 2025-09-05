from transformers import AutoTokenizer
from typing import List


def calculate_max_token_nums(model_name_or_path: str, prompts: List[str]):
    tokenizer = AutoTokenizer.from_pretrained(
        model_name_or_path
    )
    
    tokenized_prompts = tokenizer(prompts, padding=True, truncation=True, return_tensors='pt')

    return int(tokenized_prompts['input_ids'].shape[1])