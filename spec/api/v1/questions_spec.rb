require 'rails_helper'

describe 'Questions API', type: :request do
  let(:headers) { { "ACCEPT" => 'application/json' } }
  let(:access_token) {create(:access_token) }
  let!(:questions) { create_list(:question_with_file, 2) }
  let(:question) { questions.first }

  describe 'GET api/v1/questions' do
    let(:api_path) { '/api/v1/questions' }
    let(:method) { :get }

    it_behaves_like 'API Authorizable'

    context 'authorized' do
      context 'index' do
        before { get api_path, params: { access_token: access_token.token }, headers: headers }

        it_behaves_like 'API return status'

        let(:questions_json) { json['questions'] }
        it 'return questions' do
          expect(questions_json.count).to eq 2
        end

        it 'returns all public fields' do
          %w[id title body created_at updated_at].each do |attr|
            expect(questions_json.first[attr]).to eq question.send(attr).as_json
          end
        end
      end
    end
  end

  describe 'GET api/v1/questions/:id' do
    let(:api_path) { "/api/v1/questions/#{question.id}" }
    let(:method) { :get }

    it_behaves_like 'API Authorizable'

    context 'authorized' do
      context 'show' do
        let!(:answers) {create_list(:answer, 2, question: question)}
        let!(:comments) {create_list(:comment, 2, commentable: question)}
        let!(:links) {create_list(:link, 2, linkable: question)}

        before { get api_path, params: { access_token: access_token.token },
                                                         headers: headers }

        it_behaves_like 'API return status'

        let(:json_question) { json['question'] }
        it 'return question' do
          expect(json_question['id']).to eq question.id
        end

        it 'returns all public fields' do
          %w[id title body author_id best_answer_id created_at updated_at].each do |attr|
            expect(json_question[attr]).to eq question.send(attr).as_json
          end
        end

        it 'returns a list of links to a question' do
          expect(json_question['links']).to match_array(links.as_json)
        end

        it 'returns a list of answers to a question' do
          expect(json_question['answers']).to match_array(answers.as_json)
        end

        it 'returns a list of comments to a question' do
          expect(json_question['comments']).to match_array(comments.as_json)
        end

        it 'returns a list of attached files to the question' do
          expect(json_question['files']).to match_array(question.files.first.url.as_json)
        end
      end
    end
  end

  describe 'POST api/v1/questions' do
    let(:api_path) { "/api/v1/questions" }
    let(:method) { :post }

    it_behaves_like 'API Authorizable'

    context 'authorized' do
      context 'create' do
        before { post api_path, params: { access_token: access_token.token,
                                          question: attributes_for(:question) },
                                          headers: headers}
        it_behaves_like 'API return status'

        it 'create new question' do
          expect { post api_path, params: { access_token: access_token.token,
                                            question: attributes_for(:question) },
                                            headers: headers}.to change(Question, :count).by(1)
        end
      end
    end
  end

  describe 'PATCH api/v1/questions/:id' do
    let(:api_path) { "/api/v1/questions/#{question.id}" }
    let(:method) { :patch }

    it_behaves_like 'API Authorizable'

    context 'authorized' do
      context 'update' do
        before { patch api_path, params: { access_token: access_token.token,
                                 question:{ title: 'updated title'} },
                                 headers: headers}
        it_behaves_like 'API return status'

        it 'update question' do
          question.reload
          expect(question.title).to eq 'updated title'
        end
      end
    end
  end

  describe 'DELETE api/v1/questions/:id' do
    let(:api_path) { "/api/v1/questions/#{question.id}" }
    let(:method) { :delete }

    it_behaves_like 'API Authorizable'

    context 'authorized' do
      context 'delete' do
        it 'returns 200 status' do
          delete api_path, params: { access_token: access_token.token}, headers: headers
          expect(response).to be_successful
        end

        it 'delete question' do
          expect{ delete api_path, params: { access_token: access_token.token}, headers: headers }.to change(Question, :count).by(-1)
        end
      end
    end
  end
end
