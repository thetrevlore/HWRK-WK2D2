# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :integer          not null, primary key
#  cat_id     :integer          not null
#  start_date :date             not null
#  end_date   :date             not null
#  status     :string           default("PENDING"), not null
#  created_at :datetime
#  updated_at :datetime
#

class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, :start_date, :end_date, presence: true
  validates :status, inclusion: {in: %w(PENDING APPROVED DENIED)}
  validates :does_not_overlap_approved_request

  belongs_to :cat,
    class_name: 'Cat',
    primary_key: :id,
    foreign_key: :cat_id

  def overlapping_requests
    CatRentalRequest.where.not("start_date > ? OR end_date < ? OR id = ?", end_date, start_date, id)
  end

  def overlapping_approved_requests
    overlapping_requests.where(status: "APPROVED")
  end

  def does_not_overlap_approved_request
    overlapping_approved_requests.exists?
  end
end
