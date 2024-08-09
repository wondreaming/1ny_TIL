import "./App.css";

function App() {
  let title = "강남 우동 맛집";
  return (
    <div className="App">
      <div className="black-nav">
        <h4 style={{ color: "red", fontSize: "24px" }}>블로그</h4>
      </div>
      <h4>{title}</h4>
    </div>
  );
}

export default App;
