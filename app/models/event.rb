# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  has_many :event_attendings, foreign_key: :attended_event_id, dependent: :delete_all
  has_many :attendees, through: :event_attendings, source: :attendee

  validates :title, presence: true
  validates :description, presence: true
  validates :date, presence: true
  validates :location, presence: true
  validates :creator, presence: true

  scope :past, -> { where('date <= ?', Time.now) }
  scope :upcoming, -> { where('date >= ?', Time.now) }

  def future?
    date > Time.now
  end
end
