defmodule KV.Bucket do
  @doc """
  新しいバケットを開始する
  """

  def start_link do
    Agent.start_link(fn -> HashDict.new end)
  end

  @doc """
  バケットから値を取得する
  """
  def get(bucket, key) do
    Agent.get(bucket, &HashDict.get(&1, key))
  end

  @doc """
  バケットから渡された値を表示する
  """
  def put(bucket, key, value) do
    Agent.update(bucket, &HashDict.put(&1, key, value))
  end

  @doc """
  キーとバケットの削除

  キーが存在すれば、そのキーの値を返す
  """
  def delete(bucket, key) do
    Agent.get_and_update(bucket, fn dict ->
      HashDict.pop(dict, key)
    end)
  end
end
