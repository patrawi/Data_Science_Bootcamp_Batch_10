let currentMood = "";
function onMoodClicked(feeling) {
  currentMood = feeling;
}

function getMoodColor(mood) {
  if (mood === "good") {
    return "green";
  } else if (mood === "neutral") {
    return "orange";
  } else {
    return "red";
  }
}

function onDescriptionSubmitted(description) {
  const moodSection = document.querySelector(".mood-section");
  console.log(currentMood);
  let moodColor = getMoodColor(currentMood);
  let cell = document.createElement("div");
  cell.style.backgroundColor = moodColor;
  cell.style.width = "15px";
  cell.style.height = "15px";
  moodSection.appendChild(cell);

  const descriptionLabel = document.getElementById("description-label");
  const ddescriptionValue = document.getElementById("description").value;
  descriptionLabel.textContent = ddescriptionValue;
}
