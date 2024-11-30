# AiGenie: AI-Powered Culinary Assistant 🧞‍♂️

AiGenie is a mobile application designed to simplify cooking and content creation using AI. It offers features like generating recipes from food images, creating blog posts, planning weekly meals, and recommending recipes based on available ingredients. Leveraging the power of Gemini and Spoonacular APIs, AiGenie enhances the culinary experience through smart AI integrations.

---

## Features 🌟
![Alt text](/Users/manya./Projects/aigenie/genie/assets/homescreen.png)

1. **Recipe Generator from Images**  
   Upload a food image, and AiGenie generates a detailed recipe using the Gemini API.
   ![Alt text](/Users/manya./Projects/aigenie/genie/assets/images/recipe.png) ![Alt text](/Users/manya./Projects/aigenie/genie/assets/images/recipe_out.png)   

2. **Caption and Blog Generator**  
   Turn food images into engaging blog posts or captions. Customize tone, style, and word limits for creativity.

3. **Weekly Meal Planner**  
   Plan meals for the week with personalized recommendations using the Spoonacular API.

4. **Recipe Recommendations**  
   Get tailored recipe suggestions based on the ingredients you have on hand.

---

## Technologies Used 🛠️

- **Frontend**: Flutter (supports both iOS and Android)  
- **APIs**:  
  - Gemini API: Image-to-text conversion for recipes and blogs.  
  - Spoonacular API: Meal planning and recipe data.  
- **Backend**: API integration via HTTP requests  
- **Design**: Minimalist UI with responsive components  

---

## Installation 🔧

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/your-username/aigenie.git
   cd aigenie

## Install Dependencies:
```flutter pub get
   


## Set Up Environment Variables

1. **Create a `.env` file in the root directory.**
2. **Add your API keys:**
GEMINI_API_KEY=your_gemini_api_key
SPOONACULAR_API_KEY=your_spoonacular_api_key

