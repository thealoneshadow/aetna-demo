function formatAIResponse(content: string): string {
  if (!content) return '';

  return (
    content
      // Convert stringified \n to real line breaks
      .replace(/\\n/g, '\n')

      // Fix broken code blocks
      .replace(/```([^\n])/g, '```\n$1') // start block properly
      .replace(/([^`])```/g, '$1\n```') // end block properly

      // Ensure all code blocks are surrounded by line breaks
      .replace(/```/g, '\n```\n')

      // Normalize multiple newlines
      .replace(/\n{3,}/g, '\n\n')

      // Trim extra spaces at start/end
      .trim()
  );
}
