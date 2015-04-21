json.array!(@employees) do |employee|
  json.extract! employee, :id, :name, :hiredate, :salary, :fulltime, :vacationdays, :comments
  json.url employee_url(employee, format: :json)
end
