let model;

// Load the BlazeFace model
async function loadModel() {
    model = await blazeface.load();
    console.log("BlazeFace model loaded!");
}

// Detect faces from a video or image element
async function detectFaces(videoElementId) {
    if (!model) {
        console.log("Model not loaded yet.");
        return [];
    }

    let video = document.getElementById(videoElementId);
    const predictions = await model.estimateFaces(video, false);
    
    return predictions; // Returns an array of detected faces
}

// Call this function when the page loads
loadModel();
