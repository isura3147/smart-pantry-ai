from fastapi import FastAPI

# Initialize the FastAPI app
app = FastAPI(
    title="SmartPantry AI - Enterprise API",
    description="Backend API for the SmartPantry Flutter App",
    version="1.0.0"
)

# A simple health-check route to ensure the server is running
@app.get("/")
def health_check():
    return {
        "status": "online", 
        "message": "Welcome to the SmartPantry AI Backend. Pick a feature and start coding!"
    }

# We will import and include our feature routers here later.
# Example: app.include_router(ocr_scanner.router.router, prefix="/api/ocr")
