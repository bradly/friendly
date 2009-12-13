require File.expand_path("../../spec_helper", __FILE__)

describe "Friendly::Cache::ByID" do
  before do
    @cache    = stub(:set => nil)
    @klass    = stub(:name => "Product")
    @id_cache = Friendly::Cache::ByID.new(@klass, [:id], @cache)
  end

  describe "when an object is created" do
    before do
      @uuid = stub(:to_guid => "xxxx-xxx-xxx-xxxx")
      @doc  = stub(:id => @uuid)
      @id_cache.create(@doc)
    end

    it "sets the cache value in the db" do
      @cache.should have_received(:set).with("Product/#{@uuid.to_guid}", @doc)
    end
  end

  describe "when an object is updated" do
    before do
      @uuid = stub(:to_guid => "xxxx-xxx-xxx-xxxx")
      @doc  = stub(:id => @uuid)
      @id_cache.update(@doc)
    end

    it "sets the cache value in the db" do
      @cache.should have_received(:set).with("Product/#{@uuid.to_guid}", @doc)
    end
  end

  describe "finding a single object in cache" do
    before do
      @uuid         = stub(:to_guid => "xxxx-xxx-xxx-xxxx")
      @doc          = stub
      @cache.stubs(:get).with("Product/xxxx-xxx-xxx-xxxx").returns(@doc).yields
      @block_called = true
      @returned = @id_cache.first(query(:id => @uuid)) do
        @block_called = true
      end
    end

    it "returns the document" do
      @returned.should == @doc
    end

    it "passes along the block to the memcached object" do
      @block_called.should be_true
    end
  end
end