# frozen_string_literal: true

RSpec.describe CascadeValidator do
  let(:child_klass) do
    child_test_class = Class.new do
      attr_accessor :name, :age

      include ActiveModel::Validations
      validates :name, presence: true
      validates :age, presence: true, inclusion: { in: 18..65 }
    end

    stub_const('Child', child_test_class)
  end

  context '対象が配列ではないとき' do
    let(:klass) do
      test_class = Class.new do
        attr_accessor :child

        include ActiveModel::Validations

        validates :child, cascade: true
      end

      stub_const('TestClass', test_class)
    end

    let(:model) do
      klass.new.tap do |instance|
        instance.child = child_klass.new
      end
    end

    it 'validatesに渡されたメソッドに対してvalid?による検証を行う' do
      aggregate_failures do
        expect(model.valid?).to be false
        model.child.name = 'hoge'
        model.child.age = 18
        expect(model.valid?).to be true
        model.child.age = 11
        expect(model.valid?).to be false
      end
    end
  end

  context 'valueがnilを返却する時' do
    let(:klass) do
      test_class = Class.new do
        attr_accessor :child

        include ActiveModel::Validations

        validates :child, cascade: true
      end

      stub_const('TestClass', test_class)
    end

    let(:model) do
      klass.new.tap do |instance|
        instance.child = child_klass.new
      end
    end

    before { model.child = nil }

    it 'cascadeは実行されないため評価はスキップされる。' do
      expect(model.valid?).to be true
    end
  end

  context '対象が配列のとき' do
    let(:klass) do
      children_test_class = Class.new do
        attr_accessor :children

        include ActiveModel::Validations

        validates :children, cascade: true
      end

      stub_const('TestClass', children_test_class)
    end

    let(:model) do
      klass.new.tap do |instance|
        instance.children = Array.new(3) { child_klass.new }
      end
    end

    it 'validatesに渡されたメソッドに対してvalid?による検証を行う' do
      aggregate_failures do
        expect(model.valid?).to be false
        model.children.first.name = 'hoge'
        model.children.first.age = 18
        expect(model.valid?).to be false
        model.children.second.name = 'hoge'
        model.children.second.age = 18
        expect(model.valid?).to be false
        model.children.third.name = 'hoge'
        model.children.third.age = 18
        expect(model.valid?).to be true
        model.children.second.age = 11
        expect(model.valid?).to be false
      end
    end
  end
end
