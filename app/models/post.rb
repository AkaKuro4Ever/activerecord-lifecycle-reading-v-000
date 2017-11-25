class Post < ActiveRecord::Base

  belongs_to :author
  validate :is_title_case

   #we want to run #make_title_case this whenever someone tries to save to the database. This is where the before_save comes in
   #However, the above validation is working before before_save, so change it to before_validation
   #Here is a rule of thumb: Whenever you are modifying an attribute of the model, use before_validation. If you are doing some other action, then use before_save.

  before_validation :make_title_case
  before_save :email_author_about_post
  private

  def is_title_case
    if title.split.any?{|w|w[0].upcase != w[0]}
      errors.add(:title, "Title must be in title case")
    end
  end

  def make_title_case
    self.title = self.title.titlecase
  end
end
