* Generating the TE domain(dataset);
data te;
    STUDYID = "SCL002";
    domain = "TE";
    ectd = "SCRN";
    element = "Screen";
    testrl = "Informed Consent";
    teenrl = "Screening Assessments are complete, up to 1 week after start of Element";
    tedur = "P7D"; output;

    ectd = "K";
    element = "SCLA";
    testrl = "First dose of study drug";
    teenrl = "4 days to 1 week after start of element";
    tedur = "P7D"; output;

    ectd = "FU";
    element = "Follow Up";
    testrl = "Follow Up";
    teenrl = "After the last PK plasma sample or 1 week after last dose";
    tedur = "P7D"; output;
run;
