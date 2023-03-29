defmodule BarcodesWeb.UserRegistrationController do
  use BarcodesWeb, :controller

  alias Barcodes.Accounts
  alias Barcodes.Accounts.User
  alias BarcodesWeb.UserAuth

  plug :put_layout, "session.html"

  def get_id_number do
    if is_nil(Accounts.get_last_id_number) do
      "001"
    else
      new_number = String.to_integer(Accounts.get_last_id_number) + 1
      case Integer.to_charlist(new_number) |> length do
        1 -> "00"<> Integer.to_string(new_number)
        2 -> "0"<> Integer.to_string(new_number)
        3 -> Integer.to_string(new_number)
      end
    end
  end

  @spec new(Plug.Conn.t(), any) :: Plug.Conn.t()
  def new(conn, _params) do
    changeset = Accounts.change_user_registration(%User{})
    id_number = get_id_number()
    IO.inspect(id_number)
    render(conn, "new.html", changeset: changeset, id_number: id_number)
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.register_user(user_params) do
      {:ok, user} ->
        {:ok, _} =
          Accounts.deliver_user_confirmation_instructions(
            user,
            &Routes.user_confirmation_url(conn, :edit, &1)
          )

        conn
        |> put_flash(:info, "User created successfully.")
        |> UserAuth.log_in_user(user)

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end


end
