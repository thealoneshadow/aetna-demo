const grouped = [];
const map = new Map();

input.forEach(({ question, answer, feedback }) => {
  if (feedback !== "positive") return; // ❌ Skip non-positive

  if (map.has(question)) {
    map.get(question).answers.push(answer);
  } else {
    const entry = { question, answers: [answer] };
    map.set(question, entry);
    grouped.push(entry);
  }
});
