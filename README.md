🚀 Upload Manager (iOS - SwiftUI)

A sample iOS application built with SwiftUI that demonstrates how to handle multiple image uploads with progress tracking, concurrency control, and clean architecture principles.

⸻

🧠 Overview

This project simulates a real-world scenario where users select multiple images and upload them to a server while:
	•	tracking individual upload progress
	•	handling success and failure states
	•	limiting concurrent uploads
	•	maintaining a responsive UI

It was designed to explore modern Swift patterns and system design concepts applied to mobile development.

⸻

🏗 Architecture

The app follows a simplified MVVM + Service Layer approach:
	•	View (SwiftUI) → UI rendering and user interaction
	•	ViewModel → business logic, upload orchestration, state management
	•	ImageHandler → async image loading from PhotosPicker
	•	UploadService → abstracted upload layer (dependency injected)

⸻

⚙️ Key Features

📸 Image Selection
	•	Uses PhotosPicker
	•	Asynchronous image loading via loadTransferable
	•	Decoupled into a dedicated ImageHandler

⸻

📊 Upload Management
	•	Each image is represented as an UploadItem
	•	Tracks:
	•	progress (0 → 1)
	•	status (pending, uploading, success, failed)

⸻

⚡ Concurrency Control
	•	Uses async/await and TaskGroup
	•	Supports limited parallel uploads
	•	Prevents overloading network/resources

⸻

🔁 Error Handling
	•	Proper do/catch handling
	•	Failure states reflected in UI
	•	Easily extendable for retry logic

⸻

🎨 Dynamic UI Feedback
	•	Real-time progress bars
	•	Success / failure indicators
	•	Fully reactive via @Published + SwiftUI

⸻

🧪 Unit Testing
	•	ViewModel is fully testable via dependency injection
	•	UploadServiceProtocol enables mocking
	•	Covers:
	•	success scenarios
	•	failure scenarios

  🛠 Technologies
	•	Swift
	•	SwiftUI
	•	Combine
	•	async/await
	•	PhotosUI

⸻

💡 What This Project Demonstrates
	•	Modern Swift concurrency patterns
	•	State-driven UI with SwiftUI
	•	Separation of concerns
	•	Testable architecture
	•	Handling large/batch operations on mobile

⸻

🚀 Possible Improvements
	•	Background uploads using URLSessionConfiguration.background
	•	Retry mechanism with exponential backoff
	•	Persistence (resume uploads after app restart)
	•	Actor-based upload queue
	•	Progress aggregation (overall upload progress)

⸻

🎯 Motivation

This project was built as a hands-on exercise to deepen knowledge in:
	•	SwiftUI
	•	concurrency
	•	system design for mobile applications
