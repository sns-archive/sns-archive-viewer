import { createFileRoute } from "@tanstack/react-router";
import Counter from "./-components/Counter";

export const Route = createFileRoute("/sample/")({
  component: RouteComponent,
});

function RouteComponent() {
  return <Counter />;
}
