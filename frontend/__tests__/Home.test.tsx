import "@testing-library/jest-dom";
import { render, screen } from "@testing-library/react";
import Home from "../src/components/Test/Home";

describe("Homeコンポーネントのテスト", () => {
  it("見出しがレンダリングされること", () => {
    render(<Home />);

    const heading = screen.getByRole("heading", { level: 1 });

    expect(heading).toBeInTheDocument();
  });
});
