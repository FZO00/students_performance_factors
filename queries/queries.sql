-- Queries for Student Performance Analysis

-- avg_exam_score_by_study_and_extracurricular
-- This query calculates the average exam score for students who studied more than 10 hours and participated in extracurricular activities.
-- It groups the results by the number of hours studied and orders them in descending order.

SELECT hours_studied, AVG(exam_score) AS avg_exam_score
FROM student_performance
WHERE hours_studied > 10 AND extracurricular_activities = 'Yes'
GROUP BY hours_studied 
ORDER BY hours_studied DESC;


-- avg_exam_score_by_hours_studied_range
-- This query categorizes students into four study hour ranges and calculates the average exam score for each range.
-- The ranges are: 1-5 hours, 6-10 hours, 11-15 hours, and 16+ hours.
-- It orders the results by the average exam score in descending order.

SELECT 
    CASE 
        WHEN hours_studied <= 5 AND hours_studied >= 1 THEN '1-5 hours'
        WHEN hours_studied <= 10 AND hours_studied >= 6 THEN '6-10 hours'
        WHEN hours_studied <= 15 AND hours_studied >= 11 THEN '11-15 hours'
        ELSE '16+ hours'
    END AS hours_studied_range, 
    AVG(exam_score) AS avg_exam_score
FROM student_performance
GROUP BY CASE 
            WHEN hours_studied <= 5 AND hours_studied >= 1 THEN '1-5 hours'
            WHEN hours_studied <= 10 AND hours_studied >= 6 THEN '6-10 hours'
            WHEN hours_studied <= 15 AND hours_studied >= 11 THEN '11-15 hours'
            ELSE '16+ hours'
         END
ORDER BY avg_exam_score DESC;


-- student_exam_ranking
-- This query ranks students based on their exam score using the DENSE_RANK() window function.
-- It selects the columns: attendance, hours studied, sleep hours, tutoring sessions, and exam rank for the top 30 students.

SELECT 
    attendance, 
    hours_studied, 
    sleep_hours, 
    tutoring_sessions, 
    DENSE_RANK() OVER(ORDER BY exam_score DESC) AS exam_rank
FROM student_performance
ORDER BY exam_rank
LIMIT 30;
