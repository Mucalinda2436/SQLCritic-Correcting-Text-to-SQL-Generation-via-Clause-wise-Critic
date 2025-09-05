from typing import List
from openai import OpenAI
import time


class GPT:
  def __init__(self, api_key: str, base_url: str, model: str='gpt-3.5-turbo', n: int=1, stream: bool=False, temperature: float=0.0, max_tokens: int=512, top_p: float=0.9, frequency_penalty: float=1.0, presence_penalty: float=1.0, stop: List[str]=[]) -> None:
    self.api_key = api_key
    self.base_url = base_url
    self.model = model
    self.n = n
    self.stream = stream
    self.temperature = temperature
    self.max_tokens = max_tokens
    self.top_p = top_p
    self.frequency_penalty = frequency_penalty
    self.presence_penalty = presence_penalty
    self.stop = stop

  def generate(self, messages):
    try:
      key = self.api_key
      base_url = self.base_url  
      client = OpenAI(api_key=key, base_url=base_url)
      response = client.chat.completions.create(
          model=self.model,
          messages=[{"role": "user", "content": messages}],
          n=self.n,
          stream=self.stream,
          temperature=self.temperature,
          max_tokens=self.max_tokens,
          top_p=self.top_p,
          frequency_penalty=self.frequency_penalty,
          presence_penalty=self.presence_penalty,
          stop=self.stop
      )

      return response.choices[0].message.content.strip()

    except Exception as e:
      print(e)
      time.sleep(5)
      return self.generate(messages)
