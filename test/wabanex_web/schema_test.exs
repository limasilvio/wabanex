defmodule WabanexWeb.SchemaTest do
  use WabanexWeb.ConnCase, async: true

  alias Wabanex.User
  alias Wabanex.Users.Create

  describe "users queries" do
    test "When a valid id is given, returns the user", %{conn: conn} do
      params = %{email: "dev.silvio@gmail.com", name: "Silvio", password: "123456"}

      {:ok, %User{id: user_id}} = Create.call(params)

      query = """
        {
          getUser(id: "#{user_id}"){
            name
            email
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(:ok)

      expected_response = %{
        "data" => %{
          "getUser" => %{
            "email" => "dev.silvio@gmail.com",
            "name" => "Silvio"
          }
        }
      }

      assert response == expected_response
    end

    test "When a invalid id is given, returns the error", %{conn: conn} do
      params = %{email: "dev.silvio@gmail.com", name: "Silvio", password: "123456"}

      {:ok, %User{id: user_id}} = Create.call(params)

      query = """
        {
          getUser(id: "1234456"){
            name
            email
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(:ok)

      expected_response = %{"errors" => [%{"locations" => [%{"column" => 13, "line" => 2}], "message" => "Argument \"id\" has invalid value \"1234456\"."}]}

      assert response == expected_response
    end
  end

  describe "users mutation" do
    test "when all params are valid, creates the user", %{conn: conn} do
      mutation = """
        mutation {
          createUser(input: {name: "Aline Porto", email: "alineporto88@gmail.com", password: "123456"}) {
            id
            name
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: mutation})
        |> json_response(:ok)

      assert %{"data" => %{"createUser" => %{"id" => _id, "name" => "Aline Porto"}}} = response
    end
  end
end
