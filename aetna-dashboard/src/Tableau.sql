const text = "This leads to a thoughtdriving approach that improves collaboration.";

const keyword = "thoughtdriving";
const keywordIndex = text.indexOf(keyword);

const before = text.slice(0, keywordIndex);
const boldPart = text.slice(keywordIndex, keywordIndex + keyword.length);
const after = text.slice(keywordIndex + keyword.length);

return (
  <p>
    {before}
    <strong>{boldPart}</strong>
    {after}
  </p>
);
