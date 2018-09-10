require 'rails_helper'

RSpec.describe "Todos", type: :request do
  let!(:todos) { create_list(:todo, 10) }
  let(:todo_id) { todos.first.id }

  describe "GET /todos" do
    before { get '/todos' }

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
      before { get "/todos/#{todo_id}" }

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
      before { get "/todos/#{todo_id}" }

      it 'return http status 404' do
        expect(response).to have_http_status(404)
      end

      it 'return a not found message' do 
        expect(json["error"]).to match(/Couldn't find Todo/)
      end 
    end
  end

  describe "POST /todos" do
    
  end

  describe "PUT /todos:id" do
    
  end

  describe "DELETE /todos" do
    
  end
end
