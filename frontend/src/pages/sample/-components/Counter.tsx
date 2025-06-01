import { useState } from "react";

const Counter = () => {
  const [count, setCount] = useState(0);

  return (
    <div className="p-6 max-w-sm mx-auto bg-white rounded-2xl shadow-md text-center space-y-4">
      <h2 className="text-2xl font-bold">カウンター</h2>
      <p className="text-lg text-gray-700">
        現在の値:{" "}
        <span className="font-mono" data-testid="counter">
          {count}
        </span>
      </p>
      <div className="flex justify-center space-x-4">
        <button
          type="button"
          onClick={() => setCount(count - 1)}
          className="px-4 py-2 bg-red-500 text-white rounded hover:bg-red-600 transition"
        >
          -1
        </button>
        <button
          type="button"
          onClick={() => setCount(0)}
          className="px-4 py-2 bg-gray-300 text-gray-800 rounded hover:bg-gray-400 transition"
        >
          Reset
        </button>
        <button
          type="button"
          onClick={() => setCount(count + 1)}
          className="px-4 py-2 bg-blue-500 text-white rounded hover:bg-blue-600 transition"
        >
          +1
        </button>
      </div>
    </div>
  );
};

export default Counter;
