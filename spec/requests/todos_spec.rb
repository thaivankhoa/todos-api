require 'rails_helper'

RSpec.describe "Todos", type: :request do
  let(:user) { create(:user) }
  let!(:todos) { create_list(:todo, 10, created_by: user.id) }
  let(:todo_id) { todos.first.id }
  let(:headers) { valid_headers }


  describe "GET /todos" do
    before { get '/todos', params: {}, headers: headers  }

    it 'return http status 200' do
      expect(response).to have_http_status(200)
    end

    it 'return todos data' do
      expect(json).not_to be_empty
      expect(json["data"].size).to eq(10)
    end 
  end

  describe "GET /todos/:id" do

    context "when record exist" do
      before { get "/todos/#{todo_id}", params: {}, headers: headers }

      it 'return http status 200' do
        expect(response).to have_http_status(200)
      end

      it 'return todo data' do 
        expect(json).not_to be_empty
        expect(json['data']['id']).to eq(todo_id.to_s)
      end 
    end

    context "when record does not exist" do
      let(:todo_id) { 100 }
      before { get "/todos/#{todo_id}", params: {}, headers: headers }

      it 'return http status 404' do
        expect(response).to have_http_status(404)
      end

      it 'return a not found message' do 
        expect(json["error"]).to match(/Couldn't find Todo/)
      end 
    end
  end

  describe "POST /todos" do
    let(:valid_params) { { title: 'Interview', created_by: user.id.to_s }.to_json }

    context 'when the request is valid' do
      before { post '/todos', params: valid_params, headers: headers }

      it 'creates a todo' do
        expect(json["data"]["attributes"]["title"]).to eq("Interview")
      end

      it 'return status code 201' do 
        expect(response).to have_http_status(201)
      end
    end

    context "when the request is invalid" do
      let(:invalid_params) { { title: nil }.to_json }
      before { post '/todos', params: invalid_params, headers: headers }

      it 'return 422 status' do
        expect(response).to have_http_status(422)
      end

      it 'return an invalid message' do
        expect(json["error"]).to match(/Title can't be blank/)
      end
    end
  end

  describe "PUT /todos:id" do
    let(:valid_params) { {title: "new title"}.to_json }

    describe 'when the record exist' do

      context "request is valid" do
        before { put "/todos/#{todo_id}", params: valid_params, headers: headers }

        it 'return status code 204' do
          expect(response).to have_http_status(204)
        end
      end

      context "request is invalid" do
        before { put "/todos/#{todo_id}", params: {}, headers: headers }

        it 'return status code 204' do
          expect(response).to have_http_status(204)
        end
      end
    end

    describe 'when the record is not exist' do
      before { put "/todos/11", params: valid_params, headers: headers }

      it 'return status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'return error message' do
        expect(json["error"]).to match(/Couldn't find Todo/)
      end
    end
  end

  describe "DELETE /todos" do
    before { delete "/todos/#{todo_id}", headers: headers }

    it 'return status code 204' do
      expect(response).to have_http_status(204)
    end 
  end
end
