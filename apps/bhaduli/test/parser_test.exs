defmodule Bhaduli.ParserTest do
  use Bhaduli.Case
  alias  Bhaduli.Parser
  alias Bhaduli.User
  alias Bhaduli.User.{BasicInfo , EducationalDetails}
  test "should be able to parse total number of results" do
    results = get_mock_results()
    {:ok, users_count, users} =  Parser.parse(results)
    assert users_count == 2
  end

  test "should be able to parse user basic info" do
    results = get_mock_results()
    {:ok, count, users}= Parser.parse(results)
    IO.inspect users
    assert length(users) == 2
    basic_info = %BasicInfo{age: 28, gender: "female",
                                         name: "erin"}
    assert List.first(users).basic_info == basic_info
   end

  test "should be able to parse user educational_details " do
    results = get_mock_results()
    {:ok, count, users}= Parser.parse(results)
    IO.inspect users
    assert length(users) == 2
    educational_details = %EducationalDetails{graduation: "G.B Pant", intermediate: "DIS", senior_secondary: "DIS"}

    assert List.first(users).educational_details == educational_details 
  end


  def get_mock_results do
    {:ok,
     {:search_results,
      [{"users",
        [{"score", "1.00000000000000000000e+00"}, {"_yz_rb", "users"},
         {"_yz_rt", "maps"}, {"_yz_rk", "1497702582526562"},
         {"_yz_id", "1*maps*users*1497702582526562*31"},
         {"basic_info_map.age_counter", "28"},
         {"basic_info_map.gender_register", "female"},
         {"basic_info_map.name_register", "osaka"},
         {"educational_details_map.graduation_register", "G.B Pant"},
         {"educational_details_map.intermediate_register", "DIS"},
         {"educational_details_map.senior_secondary_register", "DIS"},
         {"user_id_register", "1497702582526562"}]},
       {"users",
        [{"score", "1.00000000000000000000e+00"}, {"_yz_rb", "users"},
         {"_yz_rt", "maps"}, {"_yz_rk", "1497702582787612"},
         {"_yz_id", "1*maps*users*1497702582787612*49"},
         {"basic_info_map.age_counter", "28"},
         {"basic_info_map.gender_register", "female"},
         {"basic_info_map.name_register", "erin"},
         {"educational_details_map.graduation_register", "G.B Pant"},
         {"educational_details_map.intermediate_register", "DIS"},
         {"educational_details_map.senior_secondary_register", "DIS"},
         {"user_id_register", "1497702582787612"}]}], 1.0, 2}}

  end
  
end
