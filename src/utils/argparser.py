import argparse

def get_args(*param_names):
    """
    动态生成 argparse 参数解析器，并返回解析后的 args 对象。
    
    Args:
        param_names (tuple of str): 参数名称列表。
    
    Returns:
        argparse.Namespace: 包含解析结果的对象。
    """
    parser = argparse.ArgumentParser(description="Dynamic argparse parser")
    
    for param in param_names:
        parser.add_argument(f"{param}", type=str, required=False, help=f"Input for {param}")
    
    args = parser.parse_args()
    return args