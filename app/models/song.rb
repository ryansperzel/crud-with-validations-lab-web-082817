class Song < ActiveRecord::Base
  validates :title, presence: true
  validates :released, inclusion: { in: [true, false] }
  validates :title, uniqueness: {scope: :release_year}
  validate :release_test
  validate :future_release_test

  def release_test
    if self.released == true && self.release_year == nil
      errors.add(:release_year, "Needs a release year if released")
    end
  end

  def future_release_test
    if self.release_year.to_s.to_i > Time.now.year
      errors.add(:release_year, "Release date cannot be in the future")
    end
  end

end
