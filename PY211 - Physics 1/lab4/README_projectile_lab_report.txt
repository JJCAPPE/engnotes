Projectile Motion Lab Script

Files:
- projectile_lab_report.py

How to use:
1. Open projectile_lab_report.py
2. Edit only the USER INPUT block near the top.
3. Replace the sample data with your lab data.
4. Run:
       python projectile_lab_report.py
5. The script will create an output folder with:
   - table1_calibration.csv
   - table2_angles.csv
   - PNG plots
   - projectile_lab_show_work.tex
   - optional PDF if you enable compile_latex_pdf_if_available and have pdflatex installed

Important settings in USER INPUT:
- angle_input_mode:
    from_vertical   -> if your recorded launcher angles are measured from vertical
    from_horizontal -> if your recorded launcher angles are already measured from horizontal
- measured_range_uncertainty_mode:
    sem -> uncertainty on the mean range
    std -> standard deviation

What the script computes:
- mean measured range for each angle
- standard deviation of repeated shots
- uncertainty on measured range
- initial launch speed v0 from the theta = 0 deg trial
- propagated uncertainty on v0
- calculated range at each nonzero angle
- propagated uncertainty on calculated range
- residuals and z-scores for measured vs calculated comparison

Plots created:
- histogram for theta = 0 deg calibration shots
- histogram for each angle trial
- measured vs calculated range with error bars
- residuals vs angle with combined uncertainty
