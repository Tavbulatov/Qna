# frozen_string_literal: true

require 'rails_helper'

describe 'Answers API', type: :request do
  let(:headers) { { 'ACCEPT' => 'application/json' } }

  let(:access_token) { create(:access_token) }
  let!(:question) { create(:question) }
  let!(:answers) { create_list(:answer_with_file, 2, question: question) }
  let!(:answer) { answers.first }

  describe 'GET api/v1/questions/:question_id/answers' do
    let(:api_path) { "/api/v1/questions/#{question.id}/answers" }
    let(:method) { :get }

    it_behaves_like 'API Authorizable'

    context 'authorized' do
      context 'index' do
        before { get api_path, params: { access_token: access_token.token }, headers: headers }
        it_behaves_like 'API return status'

        let(:answers_json) { json['answers'] }

        it 'return answers' do
          expect(answers_json.count).to eq 2
        end

        it 'returns all public fields' do
          %w[id body created_at updated_at].each do |attr|
            expect(answers_json.first[attr]).to eq answer.send(attr).as_json
          end
        end
      end
    end
  end

  describe 'GET api/v1/answers/:id' do
    let(:api_path) { "/api/v1/answers/#{answer.id}" }
    let(:method) { :get }

    it_behaves_like 'API Authorizable'

    context 'authorized' do
      context 'show' do
        let!(:comments) { create_list(:comment, 2, commentable: answer) }
        let!(:links) { create_list(:link, 2, linkable: answer) }
        let(:answer_json) { json['answer'] }
        before do
          get api_path, params: { access_token: access_token.token },
                        headers: headers
        end

        it_behaves_like 'API return status'

        it 'return question' do
          expect(answer_json['id']).to eq answer.id
        end

        it 'returns all public fields' do
          %w[id body question_id author_id created_at updated_at].each do |attr|
            expect(answer_json[attr]).to eq answer.send(attr).as_json
          end
        end

        it 'returns a list of links to a question' do
          expect(answer_json['links']).to match_array(links.as_json)
        end

        it 'returns a list of comments to a question' do
          expect(answer_json['comments']).to match_array(comments.as_json)
        end

        it 'returns a list of attached files to the question' do
          expect(answer_json['files']).to match_array(answer.files.first.url.as_json)
        end
      end
    end
  end

  describe 'POST api/v1/questions/:question_id/answers' do
    let(:api_path) { "/api/v1/questions/#{question.id}/answers" }
    let(:method) { :post }

    it_behaves_like 'API Authorizable'

    context 'authorized' do
      context 'create' do
        before do
          post api_path, params: { access_token: access_token.token,
                                   answer: attributes_for(:answer) },
                         headers: headers
        end
        it_behaves_like 'API return status'

        it 'create new answer' do
          expect do
            post api_path, params: { access_token: access_token.token,
                                     answer: attributes_for(:answer) },
                           headers: headers
          end.to change(Answer, :count).by(1)
        end
      end
    end
  end

  describe 'PATCH api/v1/answers/:id' do
    let(:api_path) { "/api/v1/answers/#{answer.id}" }
    let(:method) { :patch }

    it_behaves_like 'API Authorizable'

    context 'authorized' do
      context 'update' do
        before do
          patch api_path, params: { access_token: access_token.token,
                                    answer: { body: 'updated body' } },
                          headers: headers
        end
        it_behaves_like 'API return status'

        it 'update answer' do
          answer.reload
          expect(answer.body).to eq 'updated body'
        end
      end
    end
  end

  describe 'DELETE api/v1/answers/:id' do
    let(:api_path) { "/api/v1/answers/#{answer.id}" }
    let(:method) { :delete }

    it_behaves_like 'API Authorizable'

    context 'authorized' do
      context 'delete' do
        it 'returns 200 status' do
          delete api_path, params: { access_token: access_token.token }, headers: headers
          expect(response).to be_successful
        end

        it 'delete answer' do
          expect do
            delete api_path, params: { access_token: access_token.token }, headers: headers
          end.to change(Answer, :count).by(-1)
        end
      end
    end
  end
end
