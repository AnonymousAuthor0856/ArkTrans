package com.example.singlefileui

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.BorderStroke
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.lazy.LazyRow
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.CenterAlignedTopAppBar
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Shapes
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.TopAppBarDefaults
import androidx.compose.material3.Typography
import androidx.compose.material3.lightColorScheme
import androidx.compose.runtime.Composable
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsCompat
import androidx.core.view.WindowInsetsControllerCompat

private const val NAME = "013_WeatherApp_en"
private const val UI_TYPE = "Weather"
private const val STYLE_THEME = "Clean Light"
private const val LANG = "en"
private const val BASELINE_SIZE = "1280x720"

object AppTokens {
    object Colors {
        val primary = Color(0xFF2196F3)
        val secondary = Color(0xFF4CAF50)
        val tertiary = Color(0xFFFF9800)
        val background = Color(0xFFF5F7FA)
        val surface = Color(0xFFFFFFFF)
        val surfaceVariant = Color(0xFFE8F5E8)
        val outline = Color(0xFFE0E0E0)
        val success = Color(0xFF4CAF50)
        val warning = Color(0xFFFF9800)
        val error = Color(0xFFF44336)
        val onPrimary = Color(0xFFFFFFFF)
        val onSecondary = Color(0xFFFFFFFF)
        val onTertiary = Color(0xFFFFFFFF)
        val onBackground = Color(0xFF263238)
        val onSurface = Color(0xFF263238)
    }
    object TypographyTokens {
        val display = TextStyle(fontSize = 20.sp, fontWeight = FontWeight.Bold, lineHeight = 24.sp, letterSpacing = (-0.2).sp)
        val headline = TextStyle(fontSize = 16.sp, fontWeight = FontWeight.SemiBold, lineHeight = 20.sp, letterSpacing = 0.sp)
        val title = TextStyle(fontSize = 14.sp, fontWeight = FontWeight.Medium, lineHeight = 18.sp, letterSpacing = 0.sp)
        val body = TextStyle(fontSize = 12.sp, fontWeight = FontWeight.Normal, lineHeight = 16.sp, letterSpacing = 0.1.sp)
        val label = TextStyle(fontSize = 10.sp, fontWeight = FontWeight.Medium, lineHeight = 12.sp, letterSpacing = 0.2.sp)
    }
    object Shapes {
        val small = RoundedCornerShape(6.dp)
        val medium = RoundedCornerShape(10.dp)
        val large = RoundedCornerShape(14.dp)
        val bottomBar = RoundedCornerShape(topStart = 14.dp, topEnd = 14.dp)
    }
    object Spacing {
        val xs = 4.dp
        val sm = 6.dp
        val md = 10.dp
        val lg = 14.dp
        val xl = 18.dp
        val xxl = 24.dp
        val xxxl = 32.dp
    }
    data class ShadowSpec(val elevation: Dp, val radius: Dp, val dy: Dp, val opacity: Float)
    object ElevationMapping {
        val level1 = ShadowSpec(1.dp, 3.dp, 1.dp, 0.1f)
        val level2 = ShadowSpec(2.dp, 5.dp, 2.dp, 0.12f)
        val level3 = ShadowSpec(4.dp, 8.dp, 3.dp, 0.15f)
        val level4 = ShadowSpec(6.dp, 12.dp, 4.dp, 0.18f)
    }
}

private val AppColorScheme = lightColorScheme(
    primary = AppTokens.Colors.primary,
    onPrimary = AppTokens.Colors.onPrimary,
    secondary = AppTokens.Colors.secondary,
    onSecondary = AppTokens.Colors.onSecondary,
    tertiary = AppTokens.Colors.tertiary,
    onTertiary = AppTokens.Colors.onTertiary,
    background = AppTokens.Colors.background,
    onBackground = AppTokens.Colors.onBackground,
    surface = AppTokens.Colors.surface,
    onSurface = AppTokens.Colors.onSurface,
    surfaceVariant = AppTokens.Colors.surfaceVariant,
    outline = AppTokens.Colors.outline,
    error = AppTokens.Colors.error
)

private val AppTypography = Typography(
    displayLarge = AppTokens.TypographyTokens.display,
    headlineMedium = AppTokens.TypographyTokens.headline,
    titleMedium = AppTokens.TypographyTokens.title,
    bodyMedium = AppTokens.TypographyTokens.body,
    labelMedium = AppTokens.TypographyTokens.label
)

@Composable
fun AppTheme(content: @Composable () -> Unit) {
    MaterialTheme(
        colorScheme = AppColorScheme,
        typography = AppTypography,
        shapes = Shapes(
            extraSmall = AppTokens.Shapes.small,
            small = AppTokens.Shapes.small,
            medium = AppTokens.Shapes.medium,
            large = AppTokens.Shapes.large,
            extraLarge = AppTokens.Shapes.large
        ),
        content = content
    )
}

data class WeatherHour(val hour: String, val temp: String, val condition: String, val color: Color)
data class WeatherDay(val day: String, val high: String, val low: String, val condition: String, val color: Color)

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun RootScreen() {
    val currentLocation = remember { mutableStateOf("New York") }
    val temperature = remember { mutableStateOf("72°") }
    val condition = remember { mutableStateOf("Sunny") }
    val feelsLike = remember { mutableStateOf("74°") }
    val humidity = remember { mutableStateOf("45%") }
    val wind = remember { mutableStateOf("5 mph") }

    val hourlyForecast = remember {
        listOf(
            WeatherHour("Now", "72°", "Sunny", AppTokens.Colors.tertiary),
            WeatherHour("1 PM", "74°", "Sunny", AppTokens.Colors.tertiary),
            WeatherHour("2 PM", "75°", "Sunny", AppTokens.Colors.tertiary),
            WeatherHour("3 PM", "76°", "Cloudy", AppTokens.Colors.primary),
            WeatherHour("4 PM", "74°", "Cloudy", AppTokens.Colors.primary),
            WeatherHour("5 PM", "72°", "Rain", AppTokens.Colors.secondary),
            WeatherHour("6 PM", "70°", "Rain", AppTokens.Colors.secondary)
        )
    }

    val weeklyForecast = remember {
        listOf(
            WeatherDay("Today", "76°", "62°", "Sunny", AppTokens.Colors.tertiary),
            WeatherDay("Mon", "74°", "60°", "Cloudy", AppTokens.Colors.primary),
            WeatherDay("Tue", "72°", "58°", "Rain", AppTokens.Colors.secondary),
            WeatherDay("Wed", "70°", "56°", "Rain", AppTokens.Colors.secondary),
            WeatherDay("Thu", "73°", "59°", "Cloudy", AppTokens.Colors.primary),
            WeatherDay("Fri", "75°", "61°", "Sunny", AppTokens.Colors.tertiary),
            WeatherDay("Sat", "77°", "63°", "Sunny", AppTokens.Colors.tertiary)
        )
    }

    Scaffold(
        contentWindowInsets = androidx.compose.foundation.layout.WindowInsets(0),
        topBar = {
            CenterAlignedTopAppBar(
                colors = TopAppBarDefaults.centerAlignedTopAppBarColors(
                    containerColor = Color.Transparent
                ),
                title = {
                    Text(text = "Weather", style = MaterialTheme.typography.displayLarge, color = MaterialTheme.colorScheme.onBackground)
                }
            )
        },
        bottomBar = {
            Surface(
                color = AppTokens.Colors.surface,
                shape = AppTokens.Shapes.bottomBar,
                tonalElevation = AppTokens.ElevationMapping.level2.elevation,
                modifier = Modifier.fillMaxWidth()
            ) {
                Row(
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(AppTokens.Spacing.md),
                    horizontalArrangement = Arrangement.SpaceEvenly,
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    Button(
                        onClick = { currentLocation.value = "New York" },
                        colors = ButtonDefaults.buttonColors(
                            containerColor = if (currentLocation.value == "New York") AppTokens.Colors.primary else AppTokens.Colors.surfaceVariant,
                            contentColor = if (currentLocation.value == "New York") AppTokens.Colors.onPrimary else AppTokens.Colors.onSurface
                        ),
                        shape = AppTokens.Shapes.medium,
                        modifier = Modifier.height(32.dp).width(80.dp)
                    ) {
                        Text(text = "NY", style = MaterialTheme.typography.labelMedium)
                    }
                    Button(
                        onClick = { currentLocation.value = "London" },
                        colors = ButtonDefaults.buttonColors(
                            containerColor = if (currentLocation.value == "London") AppTokens.Colors.primary else AppTokens.Colors.surfaceVariant,
                            contentColor = if (currentLocation.value == "London") AppTokens.Colors.onPrimary else AppTokens.Colors.onSurface
                        ),
                        shape = AppTokens.Shapes.medium,
                        modifier = Modifier.height(32.dp).width(80.dp)
                    ) {
                        Text(text = "London", style = MaterialTheme.typography.labelMedium)
                    }
                    Button(
                        onClick = { currentLocation.value = "Tokyo" },
                        colors = ButtonDefaults.buttonColors(
                            containerColor = if (currentLocation.value == "Tokyo") AppTokens.Colors.primary else AppTokens.Colors.surfaceVariant,
                            contentColor = if (currentLocation.value == "Tokyo") AppTokens.Colors.onPrimary else AppTokens.Colors.onSurface
                        ),
                        shape = AppTokens.Shapes.medium,
                        modifier = Modifier.height(32.dp).width(80.dp)
                    ) {
                        Text(text = "Tokyo", style = MaterialTheme.typography.labelMedium)
                    }
                }
            }
        },
        containerColor = MaterialTheme.colorScheme.background
    ) { padding ->
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(padding)
                .padding(horizontal = AppTokens.Spacing.md),
            verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.lg)
        ) {
            Card(
                shape = AppTokens.Shapes.large,
                colors = CardDefaults.cardColors(containerColor = AppTokens.Colors.surface),
                elevation = CardDefaults.cardElevation(defaultElevation = AppTokens.ElevationMapping.level2.elevation),
                modifier = Modifier.fillMaxWidth()
            ) {
                Column(
                    modifier = Modifier.padding(AppTokens.Spacing.lg),
                    horizontalAlignment = Alignment.CenterHorizontally,
                    verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm)
                ) {
                    Text(
                        text = currentLocation.value,
                        style = MaterialTheme.typography.headlineMedium,
                        color = MaterialTheme.colorScheme.onSurface
                    )
                    Text(
                        text = temperature.value,
                        style = TextStyle(fontSize = 32.sp, fontWeight = FontWeight.Bold, lineHeight = 36.sp),
                        color = MaterialTheme.colorScheme.onSurface
                    )
                    Text(
                        text = condition.value,
                        style = MaterialTheme.typography.titleMedium,
                        color = MaterialTheme.colorScheme.onSurface.copy(alpha = 0.7f)
                    )
                    Row(
                        modifier = Modifier.fillMaxWidth(),
                        horizontalArrangement = Arrangement.SpaceEvenly,
                        verticalAlignment = Alignment.CenterVertically
                    ) {
                        Column(
                            horizontalAlignment = Alignment.CenterHorizontally,
                            verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.xs)
                        ) {
                            Text(
                                text = "Feels like",
                                style = MaterialTheme.typography.labelMedium,
                                color = MaterialTheme.colorScheme.onSurface.copy(alpha = 0.7f)
                            )
                            Text(
                                text = feelsLike.value,
                                style = MaterialTheme.typography.bodyMedium,
                                color = MaterialTheme.colorScheme.onSurface
                            )
                        }
                        Column(
                            horizontalAlignment = Alignment.CenterHorizontally,
                            verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.xs)
                        ) {
                            Text(
                                text = "Humidity",
                                style = MaterialTheme.typography.labelMedium,
                                color = MaterialTheme.colorScheme.onSurface.copy(alpha = 0.7f)
                            )
                            Text(
                                text = humidity.value,
                                style = MaterialTheme.typography.bodyMedium,
                                color = MaterialTheme.colorScheme.onSurface
                            )
                        }
                        Column(
                            horizontalAlignment = Alignment.CenterHorizontally,
                            verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.xs)
                        ) {
                            Text(
                                text = "Wind",
                                style = MaterialTheme.typography.labelMedium,
                                color = MaterialTheme.colorScheme.onSurface.copy(alpha = 0.7f)
                            )
                            Text(
                                text = wind.value,
                                style = MaterialTheme.typography.bodyMedium,
                                color = MaterialTheme.colorScheme.onSurface
                            )
                        }
                    }
                }
            }

            Text(
                text = "Hourly Forecast",
                style = MaterialTheme.typography.headlineMedium,
                color = MaterialTheme.colorScheme.onBackground
            )

            LazyRow(
                horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm),
                modifier = Modifier.fillMaxWidth()
            ) {
                items(hourlyForecast) { hour ->
                    Card(
                        shape = AppTokens.Shapes.medium,
                        colors = CardDefaults.cardColors(containerColor = AppTokens.Colors.surface),
                        elevation = CardDefaults.cardElevation(defaultElevation = AppTokens.ElevationMapping.level1.elevation),
                        modifier = Modifier.width(70.dp)
                    ) {
                        Column(
                            modifier = Modifier.padding(AppTokens.Spacing.sm),
                            horizontalAlignment = Alignment.CenterHorizontally,
                            verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.xs)
                        ) {
                            Text(
                                text = hour.hour,
                                style = MaterialTheme.typography.labelMedium,
                                color = MaterialTheme.colorScheme.onSurface
                            )
                            Box(
                                modifier = Modifier
                                    .size(20.dp)
                                    .background(hour.color, CircleShape)
                            )
                            Text(
                                text = hour.temp,
                                style = MaterialTheme.typography.bodyMedium,
                                color = MaterialTheme.colorScheme.onSurface
                            )
                        }
                    }
                }
            }

            Text(
                text = "7-Day Forecast",
                style = MaterialTheme.typography.headlineMedium,
                color = MaterialTheme.colorScheme.onBackground
            )

            Column(
                verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm)
            ) {
                weeklyForecast.forEach { day ->
                    Card(
                        shape = AppTokens.Shapes.small,
                        colors = CardDefaults.cardColors(containerColor = AppTokens.Colors.surface),
                        elevation = CardDefaults.cardElevation(defaultElevation = AppTokens.ElevationMapping.level1.elevation),
                        modifier = Modifier.fillMaxWidth()
                    ) {
                        Row(
                            modifier = Modifier
                                .fillMaxWidth()
                                .padding(AppTokens.Spacing.md),
                            horizontalArrangement = Arrangement.SpaceBetween,
                            verticalAlignment = Alignment.CenterVertically
                        ) {
                            Text(
                                text = day.day,
                                style = MaterialTheme.typography.bodyMedium,
                                color = MaterialTheme.colorScheme.onSurface,
                                modifier = Modifier.width(40.dp)
                            )
                            Box(
                                modifier = Modifier
                                    .size(16.dp)
                                    .background(day.color, CircleShape)
                            )
                            Row(
                                horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm),
                                verticalAlignment = Alignment.CenterVertically
                            ) {
                                Text(
                                    text = day.high,
                                    style = MaterialTheme.typography.bodyMedium,
                                    color = MaterialTheme.colorScheme.onSurface
                                )
                                Text(
                                    text = day.low,
                                    style = MaterialTheme.typography.bodyMedium,
                                    color = MaterialTheme.colorScheme.onSurface.copy(alpha = 0.5f)
                                )
                            }
                        }
                    }
                }
            }

            Card(
                shape = AppTokens.Shapes.medium,
                colors = CardDefaults.cardColors(containerColor = AppTokens.Colors.surfaceVariant),
                elevation = CardDefaults.cardElevation(defaultElevation = AppTokens.ElevationMapping.level1.elevation),
                modifier = Modifier.fillMaxWidth()
            ) {
                Row(
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(AppTokens.Spacing.md),
                    horizontalArrangement = Arrangement.SpaceBetween,
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    Column(
                        verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.xs)
                    ) {
                        Text(
                            text = "UV Index",
                            style = MaterialTheme.typography.labelMedium,
                            color = MaterialTheme.colorScheme.onSurface.copy(alpha = 0.7f)
                        )
                        Text(
                            text = "Moderate",
                            style = MaterialTheme.typography.bodyMedium,
                            color = MaterialTheme.colorScheme.onSurface
                        )
                    }
                    Column(
                        verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.xs)
                    ) {
                        Text(
                            text = "Sunset",
                            style = MaterialTheme.typography.labelMedium,
                            color = MaterialTheme.colorScheme.onSurface.copy(alpha = 0.7f)
                        )
                        Text(
                            text = "7:45 PM",
                            style = MaterialTheme.typography.bodyMedium,
                            color = MaterialTheme.colorScheme.onSurface
                        )
                    }
                    Column(
                        verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.xs)
                    ) {
                        Text(
                            text = "Visibility",
                            style = MaterialTheme.typography.labelMedium,
                            color = MaterialTheme.colorScheme.onSurface.copy(alpha = 0.7f)
                        )
                        Text(
                            text = "10 mi",
                            style = MaterialTheme.typography.bodyMedium,
                            color = MaterialTheme.colorScheme.onSurface
                        )
                    }
                }
            }
        }
    }
}

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        WindowCompat.setDecorFitsSystemWindows(window, false)
        val controller = WindowInsetsControllerCompat(window, window.decorView)
        controller.systemBarsBehavior = WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
        controller.hide(WindowInsetsCompat.Type.navigationBars())
        setContent {
            AppTheme {
                Surface(color = MaterialTheme.colorScheme.background) {
                    RootScreen()
                }
            }
        }
    }
    override fun onWindowFocusChanged(hasFocus: Boolean) {
        super.onWindowFocusChanged(hasFocus)
        if (hasFocus) {
            val controller = WindowInsetsControllerCompat(window, window.decorView)
            controller.systemBarsBehavior = WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
            controller.hide(WindowInsetsCompat.Type.navigationBars())
        }
    }
}

@Preview(showBackground = true, backgroundColor = 0xFFF5F7FA)
@Composable
fun PreviewRoot() {
    AppTheme {
        RootScreen()
    }
}