<div class="container">
  <div class="heading">Heading 1</div>
  <div class="heading">Heading 2</div>
  <div class="heading">Heading 3</div>
  <div class="heading">Heading 4</div>

  <div class="content">Content 1</div>
  <div class="content">Content 2</div>
  <div class="content">Content 3</div>
  <div class="content">Content 4</div>
</div>


.container {
  display: grid;
  grid-template-columns: auto auto; /* Two columns */
  gap: 10px; /* Gap between grid items */
  transform: rotate(-90deg); /* Rotate the grid by -90 degrees */
}

.heading, .content {
  padding: 10px;
  border: 1px solid #000; /* Border for demonstration */
}

.heading {
  writing-mode: vertical-rl; /* Vertical writing mode */
  transform: rotate(180deg); /* Rotate back the heading text */
}