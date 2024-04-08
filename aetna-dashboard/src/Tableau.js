<div class="container">
  <div class="row">
    <div class="column">
      <h2 class="heading">Heading 1</h2>
      <p>This is content for column 1</p>
    </div>
    <div class="column">
      <h2 class="heading">Heading 2</h2>
      <p>This is content for column 2</p>
    </div>
    <div class="column">
      <h2 class="heading">Heading 3</h2>
      <p>This is content for column 3</p>
    </div>
    <div class="column">
      <h2 class="heading">Heading 4</h2>
      <p>This is content for column 4</p>
    </div>
  </div>
  
</div>

.container {
  display: grid;
  grid-template-columns: repeat(4, 1fr); /* 4 columns */
  gap: 10px; /* Gap between grid items */
}

.row {
  display: flex;
}

.column {
  background-color: #f0f0f0; /* Background color for the heading */
  padding: 10px;
}

.heading {
  margin: 0; /* Remove default margin */
}

.content p {
  margin: 5px 0; /* Add some space between lines of content */
}