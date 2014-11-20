class Contact < ActiveRecord::Base
  paginates_per 500
  has_one :referer, class_name: 'Contact', foreign_key: 'referer_id'
  has_many :calls, dependent: :destroy
  has_many :appointments, dependent: :destroy
  has_many :return_calls, dependent: :destroy
  belongs_to :user, counter_cache: true
  before_save :update_search_field

  validates :user, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :primary_phone, presence: true, uniqueness: true
  validates :priority_code, presence: true
  validates :status, presence: true
  validates :primary_phone, phony_plausible: true
  validates :home_phone, phony_plausible: true
  validates :office_phone, phony_plausible: true

  phony_normalize :primary_phone, default_country_code: 'NZ'
  phony_normalize :home_phone, default_country_code: 'NZ'
  phony_normalize :office_phone, default_country_code: 'NZ'

  enum priority_code: [:A, :B, :C]

  enum status: [:base_new,
                :base_not_back_until,
                :base_office_phone_only,
                :base_needs_research,
                :callback_for_appointment,
                :callback_for_decision,
                :callback_for_contacts,
                :appointment_set,
                :appointment_none,
                :appointment_no_support,
                :appointment_new_ministry_partner,
                :maintain_call_in_a_year,
                :maintain_would_have_met,
                :maintain_on_list]

  enum category: [:base, :callback, :appointment, :maintain]

  scope :calls, (lambda do
    where(status:
      Contact.statuses[:base_new]..Contact.statuses[:callback_for_contacts])
  end)

  def status=(status)
    super(status)
    return unless valid?
    send "#{status.to_s.split('_')[0]}!"
  end

  protected

  def update_search_field
    self.search =
      "%%#{first_name}%%#{last_name}%%#{address}%%#{occupation}%%#{church}%%"\
      "#{primary_phone}%%#{home_phone}%%#{office_phone}%%#{email}%%"\
      "#{children}%%#{status}"
  end
end
