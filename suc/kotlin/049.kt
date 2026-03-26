package com.example.singlefileui

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.ExperimentalFoundationApi
import androidx.compose.foundation.Image
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
import androidx.compose.foundation.lazy.grid.GridCells
import androidx.compose.foundation.lazy.grid.LazyVerticalGrid
import androidx.compose.foundation.lazy.grid.items
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Shapes
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.Typography
import androidx.compose.material3.lightColorScheme
import androidx.compose.runtime.Composable
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsCompat
import androidx.core.view.WindowInsetsControllerCompat

private const val NAME = "064*ItineraryPlanner*en"
private const val UI_TYPE = "Travel"
private const val STYLE_THEME = "Warm Gradient"
private const val LANG = "en"
private const val BASELINE_SIZE = "720x1280"

object AppTokens {
    object Colors {
        val primary = Color(0xFFFF7043)
        val secondary = Color(0xFFFFB74D)
        val tertiary = Color(0xFFFFD180)
        val background = Color(0xFFFFF8F2)
        val surface = Color(0xFFFFFFFF)
        val surfaceVariant = Color(0xFFFFE0B2)
        val outline = Color(0xFFD7CCC8)
        val success = Color(0xFF43A047)
        val warning = Color(0xFFFFB300)
        val error = Color(0xFFE53935)
        val onPrimary = Color(0xFFFFFFFF)
        val onSecondary = Color(0xFF3E2723)
        val onTertiary = Color(0xFF3E2723)
        val onBackground = Color(0xFF3E2723)
        val onSurface = Color(0xFF3E2723)
    }
    object TypographyTokens {
        val display = TextStyle(fontSize = 28.sp, fontWeight = FontWeight.Bold)
        val title = TextStyle(fontSize = 18.sp, fontWeight = FontWeight.Medium)
        val body = TextStyle(fontSize = 14.sp, fontWeight = FontWeight.Normal)
        val label = TextStyle(fontSize = 12.sp, fontWeight = FontWeight.Medium)
    }
    object Shapes {
        val small = RoundedCornerShape(8.dp)
        val medium = RoundedCornerShape(14.dp)
        val large = RoundedCornerShape(20.dp)
    }
    object Spacing {
        val sm = 6.dp
        val md = 10.dp
        val lg = 16.dp
        val xl = 24.dp
        val xxl = 36.dp
    }
    data class ShadowSpec(val elevation: Dp, val radius: Dp, val dy: Dp, val opacity: Float)
    object ElevationMapping {
        val level1 = ShadowSpec(2.dp, 4.dp, 2.dp, 0.1f)
        val level2 = ShadowSpec(6.dp, 8.dp, 4.dp, 0.15f)
        val level3 = ShadowSpec(10.dp, 12.dp, 6.dp, 0.18f)
    }
}

private val AppColorScheme = lightColorScheme(
    primary = AppTokens.Colors.primary,
    onPrimary = AppTokens.Colors.onPrimary,
    secondary = AppTokens.Colors.secondary,
    onSecondary = AppTokens.Colors.onSecondary,
    background = AppTokens.Colors.background,
    onBackground = AppTokens.Colors.onBackground,
    surface = AppTokens.Colors.surface,
    onSurface = AppTokens.Colors.onSurface,
    surfaceVariant = AppTokens.Colors.surfaceVariant,
    outline = AppTokens.Colors.outline
)

private val AppTypography = Typography(
    displayLarge = AppTokens.TypographyTokens.display,
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
            small = AppTokens.Shapes.small,
            medium = AppTokens.Shapes.medium,
            large = AppTokens.Shapes.large
        ),
        content = content
    )
}

data class TripCard(val id: Int, val title: String, val days: Int, val price: String)

@OptIn(ExperimentalFoundationApi::class)
@Composable
fun RootScreen() {
    val trips = remember {
        listOf(
            TripCard(1, "Kyoto Cherry Trail", 4, "$460"),
            TripCard(2, "Tokyo City Break", 3, "$390"),
            TripCard(3, "Osaka Gourmet Tour", 5, "$520"),
            TripCard(4, "Mount Fuji Escape", 2, "$280"),
            TripCard(5, "Okinawa Beach Week", 6, "$740"),
            TripCard(6, "Hokkaido Winter Lights", 5, "$680")
        )
    }
    Scaffold(
        contentWindowInsets = androidx.compose.foundation.layout.WindowInsets(0),
        containerColor = AppTokens.Colors.background
    ) { pad ->
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(pad)
                .background(
                    Brush.verticalGradient(
                        listOf(
                            AppTokens.Colors.secondary.copy(alpha = 0.3f),
                            AppTokens.Colors.background,
                            AppTokens.Colors.primary.copy(alpha = 0.3f)
                        )
                    )
                )
                .padding(AppTokens.Spacing.lg),
            verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.md)
        ) {
            Text("Itinerary Planner", style = AppTokens.TypographyTokens.display, color = AppTokens.Colors.primary)
            LazyVerticalGrid(
                columns = GridCells.Adaptive(160.dp),
                verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.lg),
                horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.lg),
                contentPadding = PaddingValues(bottom = AppTokens.Spacing.xxl)
            ) {
                items(trips) { trip ->
                    Card(
                        shape = AppTokens.Shapes.large,
                        colors = CardDefaults.cardColors(containerColor = AppTokens.Colors.surface),
                        elevation = CardDefaults.cardElevation(AppTokens.ElevationMapping.level2.elevation)
                    ) {
                        Column(
                            modifier = Modifier
                                .fillMaxWidth()
                                .background(AppTokens.Colors.surface)
                                .padding(AppTokens.Spacing.md),
                            verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm)
                        ) {
                            Box(
                                modifier = Modifier
                                    .fillMaxWidth()
                                    .height(100.dp)
                                    .background(AppTokens.Colors.surfaceVariant, AppTokens.Shapes.medium)
                            )
                            Text(trip.title, style = AppTokens.TypographyTokens.title, color = AppTokens.Colors.onSurface)
                            Text("${trip.days} days", style = AppTokens.TypographyTokens.body, color = AppTokens.Colors.onSurface.copy(alpha = 0.7f))
                            Row(
                                modifier = Modifier.fillMaxWidth(),
                                horizontalArrangement = Arrangement.SpaceBetween,
                                verticalAlignment = Alignment.CenterVertically
                            ) {
                                Text(trip.price, style = AppTokens.TypographyTokens.title, color = AppTokens.Colors.primary)
                                Button(
                                    onClick = {},
                                    colors = ButtonDefaults.buttonColors(containerColor = AppTokens.Colors.primary, contentColor = AppTokens.Colors.onPrimary),
                                    shape = AppTokens.Shapes.medium,
                                    modifier = Modifier.height(36.dp)
                                ) { Text("Details", style = AppTokens.TypographyTokens.label) }
                            }
                        }
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
        controller.hide(WindowInsetsCompat.Type.systemBars())
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
            controller.hide(WindowInsetsCompat.Type.systemBars())
        }
    }
}

@Preview(showBackground = true, backgroundColor = 0xFFFFF8F2)
@Composable
fun PreviewRoot() {
    AppTheme {
        RootScreen()
    }
}
