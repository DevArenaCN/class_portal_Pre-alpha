class CoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  include Register
  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.all
    @user_id = session[:user_id]
    puts @user_id
  end

  # GET /courses/1
  # GET /courses/1.json
  def show

  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)
    respond_to do |format|
      if @course.save

        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course = Course.find(params[:id])
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_path, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def new_enrollment(user,course)
    @get_instructor_id=ActiveRecord::Base.connection.execute('SELECT instructor_id FROM Course WHERE course.id = course_i.id')

    ActiveRecord::Base.connection.execute("INSERT INTO enrollments (student_id, course_id, instructor_id) VALUES (#{user.id}, #{course.id}, #{@get_instructor_id}) ")



   # @users = User.all
   # @users.each do |find_user|
   #   relevant_courses = Courses.find(:all, :conditions => ["? = courses.Instructor",find_user.name ])
    #  relevant_courses.each do |find_instructor|
    #    users.enrollments << Enrollments.create(:course_id => course.id, :student_id => user.id, :instructor_id => find_instructor.id)
     # end
   # end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:Course_num, :Title, :Description, :Instructor, :Start_date, :End_date, :Status)
    end
end
