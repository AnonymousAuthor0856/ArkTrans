import { BusinessError } from '@kit.BasicServicesKit';
import { http } from '@kit.NetworkKit';

// Define data models to match the JSON structure
export interface Prediction {
  place_id: string;
  description: string;
}

export interface AutocompleteResult {
  predictions: Prediction[];
}

export interface Location {
  lng: number;
  lat: number;
}

export interface Geometry {
  location: Location;
}

export interface PlaceDetail {
  name: string;
  geometry: Geometry;
}

export interface PlaceDetailsResult {
  result: PlaceDetail;
}

export interface City {
  name: string;
  longitude: number;
  latitude: number;
}

@Entry
@Component
struct NewCityView {
  @State search: string = '';
  @State predictions: Prediction[] = [];
  @State isValidating: boolean = false;
  
  // Mock callback for demonstration purposes
  onAdd: (city: City) => void = (city: City) => {
    console.info('City added:', city);
  };

  build() {
    Navigation() {
      Column() {
        List({ space: 8 }) {
          // Search Section
          ListItem() {
            Column() {
              Text("Search City")
                .fontSize(16)
                .fontColor(Color.Black)
                .margin({ left: 16, bottom: 8 })
              
              TextInput({ placeholder: 'Search City' })
                .type(InputType.Normal)
                .width('100%')
                .height(44)
                .backgroundColor(Color.White)
                .borderRadius(8)
                .padding({ left: 12, right: 12 })
                .onChange((value: string) => {
                  this.search = value;
                  this.handleSearch(value);
                })
            }
            .width('100%')
            .padding({ top: 16, bottom: 16, left: 16, right: 16 })
            .backgroundColor('#F2F2F7') // iOS Grouped background color
          }

          // Predictions Section
          ForEach(this.predictions, (prediction: Prediction) => {
            ListItem() {
              Button(prediction.description)
                .onClick(() => {
                  this.addCity(prediction);
                })
                .width('100%')
                .textAlign(TextAlign.Start)
                .fontColor(Color.Black)
                .backgroundColor(Color.Transparent)
                .padding({ left: 16, right: 16, top: 12, bottom: 12 })
            }
            .swipeAction({
              end: {
                content: () => {
                  Button('Delete')
                    .backgroundColor(Color.Red)
                    .width('100%')
                    .height('100%')
                },
                actionAreaWidth: 100
              }
            })
          })
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#F2F2F7')
        .divider({ strokeWidth: 0.5, color: '#C6C6C8' })
      }
      .width('100%')
      .height('100%')
    }
    .title('Add City')
    .hideTitleBar(false)
    .onBackPress(() => {
      // Handle back action if needed
      return true;
    })
  }

  private async handleSearch(query: string) {
    if (!query) {
      this.predictions = [];
      return;
    }

    try {
      const response = await this.searchCity(query);
      if (response) {
        this.predictions = response.predictions;
      }
    } catch (error) {
      console.error('Search failed:', error);
    }
  }

  private async searchCity(query: string): Promise<AutocompleteResult | null> {
    const apiKey = "YOUR_GOOGLE_MAPS_API_KEY"; // Replace with your actual API key
    const url = `https://maps.googleapis.com/maps/api/place/autocomplete/json?input=${encodeURIComponent(query)}&types=(cities)&key=${apiKey}`;
    
    try {
      const client = http.createHttp();
      const response = await client.request(url, {
        method: http.RequestMethod.GET,
        readTimeout: 10000,
        connectTimeout: 10000
      });
      
      if (response.responseCode === 200) {
        const result: AutocompleteResult = JSON.parse(response.result as string);
        return result;
      } else {
        console.error('HTTP Error:', response.responseCode);
        return null;
      }
    } catch (error) {
      console.error('Network request failed:', error);
      return null;
    }
  }

  private async addCity(prediction: Prediction) {
    this.isValidating = true;
    
    try {
      const city = await this.fetchCityDetails(prediction.place_id);
      if (city) {
        this.onAdd(city);
        // In a real app, you might want to navigate back or show success message
      }
    } catch (error) {
      console.error('Failed to fetch city details:', error);
    } finally {
      this.isValidating = false;
    }
  }

  private async fetchCityDetails(placeId: string): Promise<City | null> {
    const apiKey = "YOUR_GOOGLE_MAPS_API_KEY"; // Replace with your actual API key
    const url = `https://maps.googleapis.com/maps/api/place/details/json?placeid=${placeId}&key=${apiKey}`;
    
    try {
      const client = http.createHttp();
      const response = await client.request(url, {
        method: http.RequestMethod.GET,
        readTimeout: 10000,
        connectTimeout: 10000
      });
      
      if (response.responseCode === 200) {
        const result: PlaceDetailsResult = JSON.parse(response.result as string);
        const d = result.result;
        return {
          name: d.name,
          longitude: d.geometry.location.lng,
          latitude: d.geometry.location.lat
        };
      } else {
        console.error('HTTP Error:', response.responseCode);
        return null;
      }
    } catch (error) {
      console.error('Network request failed:', error);
      return null;
    }
  }
}