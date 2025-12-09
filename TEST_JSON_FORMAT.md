# Test JSON Format Guide

## JSON Structure

Admin should upload a JSON file with this exact format:

```json
{
  "questions": [
    {
      "question": "Your question text here?",
      "options": ["Option 1", "Option 2", "Option 3", "Option 4"],
      "correctAnswer": 0
    }
  ]
}
```

## Field Descriptions

- **questions**: Array of question objects
- **question**: The question text (string)
- **options**: Array of 4 options (strings)
- **correctAnswer**: Index of correct option (0-3)
  - 0 = First option
  - 1 = Second option
  - 2 = Third option
  - 3 = Fourth option

## Example

See `SAMPLE_TEST_JSON.json` for a complete example with 5 questions.

## Features

✅ Questions are randomly shuffled for each test attempt
✅ Timer counts down from specified duration
✅ Progress bar shows completion
✅ Can navigate between questions
✅ Results calculated automatically
✅ Shows score, correct/wrong answers, and time taken
✅ Pass mark is 40%

## Admin Upload Steps

1. Go to Admin Panel → Tests tab
2. Fill in test details (category, course, title, duration)
3. Click "Upload Questions JSON"
4. Select your JSON file
5. Set free/paid pricing
6. Click "Add Test"

## User Experience

1. User sees test in Tests screen
2. Clicks "Start" button
3. Sees test details and instructions
4. Clicks "Start Test"
5. Answers questions with timer
6. Submits test
7. Views detailed results
