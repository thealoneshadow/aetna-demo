import React from "react";
import Markdown from "markdown-to-jsx";
import { Prism as SyntaxHighlighter } from "react-syntax-highlighter";
import { dracula } from "react-syntax-highlighter/dist/esm/styles/prism";

const markdownText = `
\`\`\`sql
SELECT * FROM users WHERE name='John';
\`\`\`
`;

const MarkdownRenderer = () => {
  return (
    <div className="p-4 bg-gray-100 rounded-md">
      <Markdown
        options={{
          overrides: {
            code: {
              component: ({ className, children }) => {
                const language = className?.replace("lang-", "") || "sql";
                return (
                  <SyntaxHighlighter language={language} style={dracula}>
                    {children}
                  </SyntaxHighlighter>
                );
              },
            },
          },
        }}
      >
        {markdownText}
      </Markdown>
    </div>
  );
};

export default MarkdownRenderer;


const language = className?.replace("lang-", "") || "sql";







