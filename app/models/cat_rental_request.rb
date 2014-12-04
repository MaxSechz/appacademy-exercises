class CatRentalRequest < ActiveRecord::Base
  STATUS = %w( PENDING DENIED APPROVED )
  validates :cat_id, :start_date, :end_date, :status, presence: true
  validates :status, inclusion: { in: STATUS }
  validate :request_already_made_during_dates
  after_initialize :set_to_pending

  belongs_to :cat

  def approve!
    self.status = "APPROVED"
    CatRentalRequest.transaction do
      self.save!
      over_lapping_pending_requests.each {|request| request.deny!}
    end
  end

  def deny!
    self.update!(status: "DENIED")
  end

  def overlapping_requests
    date_query = "NOT (start_date > ? OR ? > end_date)"
    CatRentalRequest.where(cat_id: cat_id).where(date_query, end_date, start_date)
  end

  def overlapping_pending_requests
    overlapping_requests.where(status: "PENDING")
  end

  def overlapping_approved_requests
    overlapping_requests.where(status: "APPROVED")
  end

  def request_already_made_during_dates
    return if start_date.nil? || end_date.nil?
    if overlapping_approved_requests.count > 0
      errors[:start_date, :end_date] << "there is a request approved matching those dates"
    end
  end

  def set_to_pending

    self.status ||= 'PENDING'
  end

end
