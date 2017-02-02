

# Move the student file here.
for each student
    $ROLLNO
    mv <student\'s org> course-admin/literate-tools/gradings/sandbox/
    cd <above dir>
    ./script.el main.org #main.rkt
    racket -l xrepl -t testing.rkt #Scores will be in final.score
    #Gen csv entry, concat it with the rollno




