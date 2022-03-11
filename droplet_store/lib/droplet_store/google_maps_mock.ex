defmodule DropletStore.GoogleMapsMock do

  def place_details(_id) do
    {:ok, %{"result" => place_details_example()}}
  end
  
  defp place_details_example() do
    %{
      "address_components" => [
      %{"long_name" => "2", "short_name" => "2", "types" => ["street_number"]},
      %{
	"long_name" => "Avenue Félix Viallet",
	"short_name" => "Av. Félix Viallet",
	"types" => ["route"]
      },
      %{
	"long_name" => "Grenoble",
	"short_name" => "Grenoble",
	"types" => ["locality", "political"]
      },
      %{
	"long_name" => "Isère",
	"short_name" => "Isère",
	"types" => ["administrative_area_level_2", "political"]
      },
      %{
	"long_name" => "Auvergne-Rhône-Alpes",
	"short_name" => "Auvergne-Rhône-Alpes",
	"types" => ["administrative_area_level_1", "political"]
      },
      %{
	"long_name" => "France",
	"short_name" => "FR",
	"types" => ["country", "political"]
      },
      %{
	"long_name" => "38000",
	"short_name" => "38000",
	"types" => ["postal_code"]
      }
    ],
      "adr_address" => "<span class=\"street-address\">2 Av. Félix Viallet</span>, <span class=\"postal-code\">38000</span> <span class=\"locality\">Grenoble</span>, <span class=\"country-name\">France</span>",
      "business_status" => "OPERATIONAL",
      "formatted_address" => "2 Av. Félix Viallet, 38000 Grenoble, France",
      "formatted_phone_number" => "04 76 85 34 49",
      "geometry" => %{
	"location" => %{"lat" => 45.1919988, "lng" => 5.724819699999999},
	"viewport" => %{
	  "northeast" => %{"lat" => 45.1933477802915, "lng" => 5.726168680291501},
	  "southwest" => %{"lat" => 45.1906498197085, "lng" => 5.723470719708496}
	}
      },
      "icon" => "https://maps.gstatic.com/mapfiles/place_api/icons/v1/png_71/shopping-71.png",
      "icon_background_color" => "#4B96F3",
      "icon_mask_base_uri" => "https://maps.gstatic.com/mapfiles/place_api/icons/v2/shoppingcart_pinlet",
      "international_phone_number" => "+33 4 76 85 34 49",
      "name" => "Carrefour City",
      "opening_hours" => %{
	"open_now" => true,
	"periods" => [
	  %{
            "close" => %{"day" => 0, "time" => "1300"},
            "open" => %{"day" => 0, "time" => "0900"}
	  },
	  %{
            "close" => %{"day" => 1, "time" => "2200"},
            "open" => %{"day" => 1, "time" => "0700"}
	  },
	  %{
            "close" => %{"day" => 2, "time" => "2200"},
            "open" => %{"day" => 2, "time" => "0700"}
	  },
	  %{
            "close" => %{"day" => 3, "time" => "2200"},
            "open" => %{"day" => 3, "time" => "0700"}
	  },
	  %{
            "close" => %{"day" => 4, "time" => "2200"},
            "open" => %{"day" => 4, "time" => "0700"}
	  },
	  %{
            "close" => %{"day" => 5, "time" => "2200"},
            "open" => %{"day" => 5, "time" => "0700"}
	  },
	  %{
            "close" => %{"day" => 6, "time" => "2200"},
            "open" => %{"day" => 6, "time" => "0700"}
	  }
	],
	"weekday_text" => ["Monday: 7:00 AM – 10:00 PM",
			   "Tuesday: 7:00 AM – 10:00 PM", "Wednesday: 7:00 AM – 10:00 PM",
			   "Thursday: 7:00 AM – 10:00 PM", "Friday: 7:00 AM – 10:00 PM",
			   "Saturday: 7:00 AM – 10:00 PM", "Sunday: 9:00 AM – 1:00 PM"]
      },
      "photos" => [
	%{
	  "height" => 3366,
	  "html_attributions" => ["<a href=\"https://maps.google.com/maps/contrib/101749313899788179674\">Michaud Christophe</a>"],
	  "photo_reference" => "Aap_uECVOuHSlA8refj3sr_gt6Bc7nVKkrbKJ6lAAQ6lG0c92Cf6bDEHS6wQu0qp1xYsqUGprj4JvW2wURkT8y5tDGGGkIgJvQ0tUkdMpc9Nvz3OiRtdAqS-Gw8UendSmuC5gQQmXUpR3xL6mZlbTEZZ0EVc7S-S9c81w9bbgSjAPTi-_Www",
	  "width" => 5984
	}
      ],
      "place_id" => "ChIJPQfpJI31ikcRZAUAnEQyuOc",
      "plus_code" => %{
	"compound_code" => "5PRF+QW Grenoble, France",
	"global_code" => "8FQ75PRF+QW"
      },
      "rating" => 4.3,
      "reference" => "ChIJPQfpJI31ikcRZAUAnEQyuOc",
      "reviews" => [
	%{
	  "author_name" => "Uchiyama Kazuharu",
	  "author_url" => "https://www.google.com/maps/contrib/106825009228076918471/reviews",
	  "language" => "en",
	  "profile_photo_url" => "https://lh3.googleusercontent.com/a-/AOh14Gjknv7djMMS81LWLukixJUF-yxkvw35jh3qAvFLe5A=s128-c0x00000000-cc-rp-mo-ba4",
	  "rating" => 4,
	  "relative_time_description" => "2 years ago",
	  "text" => "I used this store frequently. Open until 10 pm. very convenient. A packed vegetable is easy for me to buy.",
	  "time" => 1574887432
	}
      ]
    }
  end
  
end
