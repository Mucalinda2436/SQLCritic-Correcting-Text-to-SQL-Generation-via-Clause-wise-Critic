from typing import List, Dict

def convert_to_sharegpt_format(conversation: List[str], system: str="", tools: str=""):
    conversations = []
    for turn, statement in enumerate(conversation):
        if turn % 2 == 0:
            converted_statement = {
                "from": "human",
                "value": statement
            }
            conversations.append(converted_statement)
        else:
            converted_statement = {
                "from": "gpt",
                "value": statement
            }
            conversations.append(converted_statement)
    sharegpt_conversation = {
        "conversations": conversations,
        "system": system,
        "tools": tools
    }
    return sharegpt_conversation
