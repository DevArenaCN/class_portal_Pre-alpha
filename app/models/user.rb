class User < ActiveRecord::Base
  enum role: [:student, :instructor, :admin, :superadmin]
  after_initialize :set_default_role, :if => :new_record?


  def set_default_role
    self.role ||= :student
  end
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  has_many :enrollments
  has_many :courses, through: :enrollments

  validates_presence_of :email, :password
  validates_uniqueness_of :email
  validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
end

