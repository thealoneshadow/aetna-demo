const grouped = [];
  const map = {};

  for (let i = 0; i < input.length; i++) {
    const item = input[i];

    if (item.feedback.toLowerCase() !== "positive") continue;

    if (map[item.question]) {
      map[item.question].push(item.answer);
    } else {
      map[item.question] = [item.answer];
    }
  }

  // Convert map to final array
  const result = [];

  for (const question in map) {
    result.push({
      question: question,
      answers: map[question]
    });
  }

  return result;
