import { router } from "@/main";
import { RouterProvider } from "@tanstack/react-router";
import { render, screen } from "@testing-library/react";
import userEvent from "@testing-library/user-event";
import { describe, expect, test } from "vitest";

const customRender = async () => {
  await router.navigate({
    to: "/sample",
  });

  render(<RouterProvider router={router} />);
};

describe("/sample のテスト", () => {
  test("+ボタンを押下すると、カウンターが1増加すること", async () => {
    customRender();
    const user = userEvent.setup();

    const counter = await screen.findByText("0");
    expect(counter).toHaveTextContent("0");

    const incrementButton = await screen.findByRole("button", {
      name: "+1",
    });
    expect(incrementButton).toBeInTheDocument();

    await user.click(incrementButton);
    expect(counter).toHaveTextContent("1");
  });
});
