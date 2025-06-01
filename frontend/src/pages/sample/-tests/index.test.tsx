import { router } from "@/main";
import { RouterProvider } from "@tanstack/react-router";
import { render, screen } from "@testing-library/react";
import userEvent from "@testing-library/user-event";
import { describe, expect, it } from "vitest";

const customRender = async () => {
  await router.navigate({
    to: "/sample",
  });

  render(<RouterProvider router={router} />);
};

describe("/sample のテスト", () => {
  it("+ボタンを押下すると、カウンターが1増加すること", async () => {
    customRender();
    const user = userEvent.setup();

    const counter = await screen.findByText("0");
    expect(counter).toBeInTheDocument();

    const incrementButton = await screen.findByRole("button", {
      name: "+1",
    });
    expect(incrementButton).toBeInTheDocument();

    await user.click(incrementButton);
    expect(counter).toHaveTextContent("1");
  });

  it("-ボタンを押下すると、カウンターが1減少すること", async () => {
    customRender();
    const user = userEvent.setup();

    const counter = await screen.findByText("0");
    expect(counter).toBeInTheDocument();

    const decrementButton = await screen.findByRole("button", {
      name: "-1",
    });
    expect(decrementButton).toBeInTheDocument();

    await user.click(decrementButton);
    expect(counter).toHaveTextContent("-1");
  });
});
