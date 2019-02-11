# == Schema Information
#
# Table name: lessons
#
#  id         :bigint(8)        not null, primary key
#  correct    :integer          default(0)
#  empty      :integer          default(0)
#  memorized  :integer          default(0), not null
#  wrong      :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  deck_id    :bigint(8)
#
# Indexes
#
#  index_lessons_on_deck_id  (deck_id)
#
# Foreign Keys
#
#  fk_rails_...  (deck_id => decks.id)
#

class Lesson < ApplicationRecord
  belongs_to :deck
  has_many :answers, dependent: :destroy, after_add: :update_counters

  def last_answers
    answers.last(4).first 3
  end

  def last_answer
    answers.last(2).first
  end

  def next_card_id
    cards_package = deck.cards.where(active: true).where(memorized: false).order(last_correct_answer: :asc).limit(10)
    if last_answer.status == 'correct'
      srand
      number = rand(cards_package.count)
      cards_package[number].id
    else
      last_answer.card_id
    end
  end

  private

  def update_counters(_answer)
    update_attribute(:correct, answers.where(status: 'correct').count)
    update_attribute(:wrong, answers.where(status: 'wrong').count)
    update_attribute(:empty, answers.where(status: 'empty').count)
  end
end
