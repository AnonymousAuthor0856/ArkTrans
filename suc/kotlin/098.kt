package com.example.myapplication

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.BorderStroke
import androidx.compose.foundation.background
import androidx.compose.foundation.border
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
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Add
import androidx.compose.material.icons.filled.Check
import androidx.compose.material.icons.filled.Info
import androidx.compose.material.icons.filled.PlayArrow
import androidx.compose.material.icons.filled.Settings
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.TopAppBar
import androidx.compose.material3.TopAppBarDefaults
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsCompat
import androidx.core.view.WindowInsetsControllerCompat

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Enable Edge-to-Edge
        enableEdgeToEdge()

        // Immersive Mode: Hide System Bars (Status Bar & Navigation Bar)
        val windowInsetsController = WindowCompat.getInsetsController(window, window.decorView)
        windowInsetsController.systemBarsBehavior = WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
        windowInsetsController.hide(WindowInsetsCompat.Type.systemBars())

        setContent {
            ZenBrewApp()
        }
    }
}

// --- Data Models (Pure UI Mock Data) ---

data class TeaGuide(
    val id: Int,
    val name: String,
    val origin: String,
    val temp: String,
    val time: String,
    val colorCode: Color
)

val sampleTeas = listOf(
    TeaGuide(1, "Sencha Green", "Japan", "70°C / 158°F", "1-2 min", Color(0xFF8BC34A)),
    TeaGuide(2, "Earl Grey", "Blend", "95°C / 203°F", "3-5 min", Color(0xFF795548)),
    TeaGuide(3, "Silver Needle", "China", "80°C / 176°F", "3-4 min", Color(0xFFE0E0E0)),
    TeaGuide(4, "Darjeeling", "India", "90°C / 194°F", "3 min", Color(0xFFD7CCC8)),
    TeaGuide(5, "Chamomile", "Egypt", "100°C / 212°F", "5-7 min", Color(0xFFFFEB3B)),
    TeaGuide(6, "Matcha", "Japan", "80°C / 176°F", "Whisk", Color(0xFF4CAF50)),
    TeaGuide(7, "Oolong", "Taiwan", "85°C / 185°F", "3-5 min", Color(0xFFFF9800))
)

// --- Composable UI ---

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun ZenBrewApp() {
    // Custom Light Theme Colors
    val primaryBlack = Color(0xFF121212)
    val textGrey = Color(0xFF757575)
    val backgroundWhite = Color.White
    val cardBackground = Color(0xFFF9F9F9)

    MaterialTheme(
        colorScheme = MaterialTheme.colorScheme.copy(
            background = backgroundWhite,
            surface = backgroundWhite,
            primary = primaryBlack,
            onBackground = primaryBlack,
            onSurface = primaryBlack
        )
    ) {
        Scaffold(
            containerColor = backgroundWhite,
            topBar = {
                TopAppBar(
                    title = {
                        Column {
                            Text(
                                text = "ZenBrew",
                                fontSize = 24.sp,
                                fontWeight = FontWeight.Bold,
                                color = primaryBlack,
                                letterSpacing = (-0.5).sp
                            )
                            Text(
                                text = "Mindful Steeping Guide",
                                fontSize = 14.sp,
                                color = textGrey,
                                fontWeight = FontWeight.Normal
                            )
                        }
                    },
                    actions = {
                        IconButton(onClick = { }) {
                            Icon(
                                imageVector = Icons.Default.Settings,
                                contentDescription = "Settings",
                                tint = primaryBlack
                            )
                        }
                    },
                    colors = TopAppBarDefaults.topAppBarColors(
                        containerColor = backgroundWhite,
                        scrolledContainerColor = backgroundWhite
                    )
                )
            },
            floatingActionButton = {
                // Creative use of FAB as a "Quick Timer" button
                Button(
                    onClick = {},
                    shape = RoundedCornerShape(16.dp),
                    colors = ButtonDefaults.buttonColors(
                        containerColor = primaryBlack,
                        contentColor = Color.White
                    ),
                    modifier = Modifier.height(56.dp)
                ) {
                    Icon(Icons.Default.Add, contentDescription = null)
                    Spacer(modifier = Modifier.width(8.dp))
                    Text("Custom Brew")
                }
            }
        ) { innerPadding ->
            LazyColumn(
                modifier = Modifier
                    .fillMaxSize()
                    .padding(innerPadding),
                contentPadding = PaddingValues(horizontal = 20.dp, vertical = 10.dp),
                verticalArrangement = Arrangement.spacedBy(16.dp)
            ) {
                item {
                    PromoCard(primaryBlack)
                }

                item {
                    Text(
                        text = "Collections",
                        fontSize = 18.sp,
                        fontWeight = FontWeight.SemiBold,
                        modifier = Modifier.padding(vertical = 8.dp)
                    )
                }

                items(sampleTeas) { tea ->
                    TeaItemCard(tea, cardBackground, primaryBlack, textGrey)
                }

                // Extra spacer for FAB
                item { Spacer(modifier = Modifier.height(80.dp)) }
            }
        }
    }
}

@Composable
fun PromoCard(textColor: Color) {
    Card(
        shape = RoundedCornerShape(20.dp),
        colors = CardDefaults.cardColors(containerColor = Color(0xFFF0F0F0)),
        elevation = CardDefaults.cardElevation(defaultElevation = 0.dp),
        modifier = Modifier.fillMaxWidth()
    ) {
        Row(
            modifier = Modifier
                .padding(24.dp)
                .fillMaxWidth(),
            verticalAlignment = Alignment.CenterVertically,
            horizontalArrangement = Arrangement.SpaceBetween
        ) {
            Column(modifier = Modifier.weight(1f)) {
                Text(
                    text = "Tip of the day",
                    fontSize = 12.sp,
                    color = Color.Gray,
                    fontWeight = FontWeight.Bold,
                    modifier = Modifier.padding(bottom = 4.dp)
                )
                Text(
                    text = "Use filtered water for a purer taste profile.",
                    fontSize = 16.sp,
                    fontWeight = FontWeight.Medium,
                    color = textColor
                )
            }
            Spacer(modifier = Modifier.width(16.dp))
            Surface(
                shape = CircleShape,
                color = Color.White,
                modifier = Modifier.size(48.dp)
            ) {
                Box(contentAlignment = Alignment.Center) {
                    Icon(
                        imageVector = Icons.Default.Info,
                        contentDescription = null,
                        tint = Color.Gray
                    )
                }
            }
        }
    }
}

@Composable
fun TeaItemCard(
    tea: TeaGuide,
    bgColor: Color,
    titleColor: Color,
    subtitleColor: Color
) {
    Card(
        shape = RoundedCornerShape(16.dp),
        colors = CardDefaults.cardColors(containerColor = bgColor),
        border = BorderStroke(1.dp, Color(0xFFEEEEEE)),
        elevation = CardDefaults.cardElevation(defaultElevation = 0.dp),
        modifier = Modifier.fillMaxWidth()
    ) {
        Row(
            modifier = Modifier
                .fillMaxWidth()
                .padding(16.dp),
            verticalAlignment = Alignment.CenterVertically
        ) {
            // Visual Dot identifier
            Box(
                modifier = Modifier
                    .size(50.dp)
                    .clip(CircleShape)
                    .background(Color.White)
                    .border(BorderStroke(2.dp, tea.colorCode.copy(alpha = 0.3f)), CircleShape),
                contentAlignment = Alignment.Center
            ) {
                Text(
                    text = tea.name.take(1),
                    fontSize = 20.sp,
                    fontWeight = FontWeight.Bold,
                    color = tea.colorCode
                )
            }

            Spacer(modifier = Modifier.width(16.dp))

            Column(modifier = Modifier.weight(1f)) {
                Text(
                    text = tea.name,
                    fontSize = 17.sp,
                    fontWeight = FontWeight.Bold,
                    color = titleColor
                )
                Text(
                    text = tea.origin,
                    fontSize = 12.sp,
                    color = subtitleColor
                )
                Spacer(modifier = Modifier.height(6.dp))
                Row(verticalAlignment = Alignment.CenterVertically) {
                    InfoBadge(label = tea.temp)
                    Spacer(modifier = Modifier.width(8.dp))
                    InfoBadge(label = tea.time)
                }
            }

            IconButton(
                onClick = { },
                modifier = Modifier
                    .size(40.dp)
                    .background(Color.White, CircleShape)
                    .border(1.dp, Color(0xFFE0E0E0), CircleShape)
            ) {
                Icon(
                    imageVector = Icons.Default.PlayArrow,
                    contentDescription = "Start Timer",
                    tint = titleColor,
                    modifier = Modifier.size(20.dp)
                )
            }
        }
    }
}

@Composable
fun InfoBadge(label: String) {
    Surface(
        color = Color.White,
        shape = RoundedCornerShape(6.dp),
        border = BorderStroke(1.dp, Color(0xFFE0E0E0))
    ) {
        Text(
            text = label,
            fontSize = 11.sp,
            color = Color.Black,
            modifier = Modifier.padding(horizontal = 6.dp, vertical = 2.dp)
        )
    }
}

// --- Preview Section ---

@Preview(showBackground = true, showSystemUi = true)
@Composable
fun AppPreview() {
    ZenBrewApp()
}