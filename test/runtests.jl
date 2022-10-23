using Test
using YggRepology
using GitHub

@testset "YggRepology utils" begin
    @test YggRepology.get_toml_file("JuliaBinaryWrappers/DuckDB_jll.jl", "Project.toml", "main")["version"] >= "0.2"

    @test YggRepology.get_readme("JuliaBinaryWrappers/DuckDB_jll.jl", "main") isa String

    @test occursin(
        "git repository: ",
        YggRepology.extract_readme_metadata(YggRepology.get_readme("JuliaBinaryWrappers/DuckDB_jll.jl", "main"))[:source_url][1],
    )

    @test occursin(
        "git repository: ",
        YggRepology.get_readme_metadata("JuliaBinaryWrappers/DuckDB_jll.jl", "main")[:source_url][1],
    )
    
    @test YggRepology.get_toml_metadata("JuliaBinaryWrappers/DuckDB_jll.jl", "main")[:version] >= "0.2.5"

    @test YggRepology.drop_url_from_list(["git repository: https://github.com/duckdb/duckdb.git (revision: `7c111322de1095436350f95e33c5553b09302165`)"]) == "https://github.com/duckdb/duckdb.git"

    @test [keys(YggRepology.get_binary_info(GitHub.Repo(; full_name = "JuliaBinaryWrappers/DuckDB_jll.jl", name = "DuckDB_jll.jl", default_branch = "main", updated_at = Date("2021-01-01"), pushed_at = Date("2021-01-01"))))...] == [:update_date, :pushed_at, :binary_name, :version, :source_url, :recipe_url]
end

@testset "YggRepology Integration Tests" begin
    binary_info = YggRepology.gather_all_binary_info()
    @test binary_info isa list
    @test length(binary_info) > 500

    # export_all_binary_info()

end
