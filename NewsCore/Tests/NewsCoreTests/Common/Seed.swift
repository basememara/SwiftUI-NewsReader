//
//  Seed.swift
//  NewsCoreTests
//
//  Created by Basem Emara on 2019-11-19.
//

import Foundation

let jsonString: String = """
    {
        "status": "ok",
        "totalResults": 5977,
        "articles": [
            {
                "source": {
                    "id": "wired",
                    "name": "Wired"
                },
                "author": "Laura Mallonee",
                "title": "Inside the Icelandic Facility Where Bitcoin Is Mined",
                "description": "Cryptocurrency mining now uses more of the Nordic island nation's electricity than its homes.",
                "url": "https://www.wired.com/story/iceland-bitcoin-mining-gallery/",
                "urlToImage": "https://media.wired.com/photos/5dbc37a4c955950008b26751/191:100/w_1280,c_limit/photo_barnard_explosions_4.jpg",
                "publishedAt": "2019-11-03T15:00:00Z",
                "content": "Less than two miles from Icelands Reykjavik airport sits a nondescript metal building as monolithic and drab as a commercial poultry barn. Theres a deafening racket inside, too, but it doesnt come from clucking chickens. Instead, tens of thousands of whirring… [+3426 chars]"
            },
            {
                "source": {
                    "id": "engadget",
                    "name": "Engadget"
                },
                "author": "Igor Bonifacic",
                "title": "HTC's Exodus 1s can run a full Bitcoin node for under $250",
                "description": "After first teasing the device earlier this year, HTC has detailed its new, more affordable Exodus 1s blockchain smartphone. The highlight feature of the device is that it can function as a full node. This means the phone is able to validate and transmit Bitc…",
                "url": "https://www.engadget.com/2019/10/19/htcs-exodus-1s-can-run-a-full-bitcoin-node-for-under-250/",
                "urlToImage": "https://o.aolcdn.com/images/dims?thumbnail=1200%2C630&quality=80&image_uri=https%3A%2F%2Fo.aolcdn.com%2Fimages%2Fdims%3Fresize%3D2000%252C2000%252Cshrink%26image_uri%3Dhttps%253A%252F%252Fs.yimg.com%252Fos%252Fcreatr-uploaded-images%252F2019-10%252F5b2e2540-f1bb-11e9-bfea-b6dc6bf80ca3%26client%3Da1acac3e1b3290917d92%26signature%3D73d25f92ce3e2e12bc31ab15d08b1653f623e1bc&client=amp-blogside-v2&signature=cc686e16366411e6ee953c3aaaf1001061a10e73",
                "publishedAt": "2019-10-19T12:50:00Z",
                "content": "At least that's the idea. While it's not as intensive as mining Bitcoin, running a full node still requires a lot of computing power. In fact, HTC recommends only using the feature while the phone is connected to WiFi and plugged into its power adapter. The c… [+2014 chars]"
            },
            {
                "source": {
                    "id": null,
                    "name": "Gizmodo.com"
                },
                "author": "Jennings Brown",
                "title": "French Students Will Now Have to Learn About Bitcoin",
                "description": "High school students in France may be among the first people in the world to actually understand how cryptocurrency works. Read more...",
                "url": "https://gizmodo.com/french-students-will-now-have-to-learn-about-bitcoin-1839547502",
                "urlToImage": "https://i.kinja-img.com/gawker-media/image/upload/c_fill,f_auto,fl_progressive,g_center,h_675,pg_1,q_80,w_1200/h98kxkwwec81t7xoekrj.jpg",
                "publishedAt": "2019-11-01T22:01:00Z",
                "content": "High school students in France may be among the first people in the world to actually understand how cryptocurrency works. \\nThe Next Web reports that the French education ministry, Le Ministère de lÉducation Nationale, will integrate cryptocurrency into its … [+1439 chars]"
            },
            {
                "source": {
                    "id": "mashable",
                    "name": "Mashable"
                },
                "author": "Miller Kern",
                "title": "Debunking Blockchain once and for all",
                "description": "TL;DR: The in-depth Complete Blockchain and Ethereum Programmer bundle is on sale for just $24 with the code 20LEARN20. When it comes to Bitcoin, you get the gist: Cryptocurrency is on the rise right now, it's a worthy investment, and it when it comes to top …",
                "url": "https://mashable.com/shopping/oct-20-blockchain-and-ethereum-programmer-online-courses/",
                "urlToImage": "https://mondrian.mashable.com/2019%252F10%252F20%252F20%252Fd451f6dc63634e7ebc1a6884f0de511f.0108b.jpg%252F1200x630.jpg?signature=wXr1QUIZY8rWVXkvW6qxTgQk24E=",
                "publishedAt": "2019-10-20T09:00:00Z",
                "content": "TL;DR: The in-depth Complete Blockchain and Ethereum Programmer bundle is on sale for just $24 with the code 20LEARN20.\\nWhen it comes to Bitcoin, you get the gist: Cryptocurrency is on the rise right now, it's a worthy investment, and it when it comes to top… [+1491 chars]"
            },
            {
                "source": {
                    "id": "the-next-web",
                    "name": "The Next Web"
                },
                "author": "Satoshi Nakaboto",
                "title": "Satoshi Nakaboto: ‘Chinese congress passes ‘crypto law’ after president’s endorsement of blockchain’",
                "description": "Our robot colleague Satoshi Nakaboto writes about Bitcoin every fucking day. Welcome to another edition of Bitcoin Today, where I, Satoshi Nakaboto, tell you what’s been going on with Bitcoin in the past 24 hours. As Baudriallard used to say: There’s only one…",
                "url": "https://thenextweb.com/hardfork/2019/10/27/satoshi-nakaboto-chinese-congress-passes-crypto-law-after-presidents-endorsement-of-blockchain/",
                "urlToImage": "https://img-cdn.tnwcdn.com/image/hardfork?filter_last=1&fit=1280%2C640&url=https%3A%2F%2Fcdn0.tnwcdn.com%2Fwp-content%2Fblogs.dir%2F1%2Ffiles%2F2019%2F08%2Fbitcoin_today-header_bitcoin_today.jpg&signature=30221b6a68049cc6bc3b58f3ddb38864",
                "publishedAt": "2019-10-27T10:27:41Z",
                "content": "Our robot colleague Satoshi Nakaboto writes about Bitcoin every fucking day.\\nWelcome to another edition of Bitcoin Today, where I, Satoshi Nakaboto, tell you whats been going on with Bitcoin in the past 24 hours. As Baudriallard used to say: Theres only one … [+3093 chars]"
            },
            {
                "source": {
                    "id": "google-news",
                    "name": "Google News"
                },
                "author": "Satoshi Nakaboto",
                "title": "Satoshi Nakaboto: ‘Founder of China’s first Bitcoin exchange predicts $500K BTC in 9 years’",
                "description": "Our robot colleague Satoshi Nakaboto writes about Bitcoin every fucking day. Welcome to another edition of Bitcoin Today, where I, Satoshi Nakaboto, tell you what’s been going on with Bitcoin in the past 24 hours. As Marcus Aurelius used to say: Yippee! Bitco…",
                "url": "http://feedproxy.google.com/~r/TheNextWeb/~3/DGohfwIkiQg/",
                "urlToImage": null,
                "publishedAt": "2019-11-11T10:10:02Z",
                "content": null
            },
            {
                "source": {
                    "id": "the-next-web",
                    "name": "The Next Web"
                },
                "author": "Satoshi Nakaboto",
                "title": "Satoshi Nakaboto: ‘China will no longer crack down on Bitcoin mining’",
                "description": "Our robot colleague Satoshi Nakaboto writes about Bitcoin every fucking day. Welcome to another edition of Bitcoin Today, where I, Satoshi Nakaboto, tell you what’s been going on with Bitcoin in the past 24 hours. As Machiavelli used to say: Fight the power! …",
                "url": "https://thenextweb.com/hardfork/2019/11/07/satoshi-nakaboto-china-will-no-longer-crack-down-on-bitcoin-mining/",
                "urlToImage": "https://img-cdn.tnwcdn.com/image/hardfork?filter_last=1&fit=1280%2C640&url=https%3A%2F%2Fcdn0.tnwcdn.com%2Fwp-content%2Fblogs.dir%2F1%2Ffiles%2F2019%2F08%2Fbitcoin_today-header_bitcoin_today.jpg&signature=30221b6a68049cc6bc3b58f3ddb38864",
                "publishedAt": "2019-11-07T09:30:27Z",
                "content": "Our robot colleague Satoshi Nakaboto writes about Bitcoin BTC every fucking day.\\nWelcome to another edition of Bitcoin Today, where I, Satoshi Nakaboto, tell you whats been going on with Bitcoin in the past 24 hours. As Machiavelli used to say: Fight the pow… [+2761 chars]"
            },
            {
                "source": {
                    "id": "the-next-web",
                    "name": "The Next Web"
                },
                "author": "Satoshi Nakaboto",
                "title": "Satoshi Nakaboto: ‘Bitcoin tries to break through $9,500 (no luck, again)’",
                "description": "Our robot colleague Satoshi Nakaboto writes about Bitcoin every fucking day. Welcome to another edition of Bitcoin Today, where I, Satoshi Nakaboto, tell you what’s been going on with Bitcoin in the past 24 hours. As Nietzsche used to say: Time is money! Bitc…",
                "url": "https://thenextweb.com/hardfork/2019/11/05/satoshi-nakaboto-bitcoin-tries-to-break-through-9500-no-luck-again/",
                "urlToImage": "https://img-cdn.tnwcdn.com/image/hardfork?filter_last=1&fit=1280%2C640&url=https%3A%2F%2Fcdn0.tnwcdn.com%2Fwp-content%2Fblogs.dir%2F1%2Ffiles%2F2019%2F08%2Fbitcoin_today-header_bitcoin_today.jpg&signature=30221b6a68049cc6bc3b58f3ddb38864",
                "publishedAt": "2019-11-05T09:29:07Z",
                "content": "Our robot colleague Satoshi Nakaboto writes about Bitcoin BTC every fucking day.\\nWelcome to another edition of Bitcoin Today, where I, Satoshi Nakaboto, tell you whats been going on with Bitcoin in the past 24 hours. As Nietzsche used to say: Time is money!\\n… [+3095 chars]"
            },
            {
                "source": {
                    "id": "the-next-web",
                    "name": "The Next Web"
                },
                "author": "Satoshi Nakaboto",
                "title": "Satoshi Nakaboto: ‘Bitcoin futures trading on Bakkt is way up compared with first month’",
                "description": "Our robot colleague Satoshi Nakaboto writes about Bitcoin every fucking day. Welcome to another edition of Bitcoin Today, where I, Satoshi Nakaboto, tell you what’s been going on with Bitcoin in the past 24 hours. As Isaac Newton used to say: The long and win…",
                "url": "https://thenextweb.com/hardfork/2019/11/08/satoshi-nakaboto-bitcoin-futures-trading-on-bakkt-is-way-up-compared-with-first-month/",
                "urlToImage": "https://img-cdn.tnwcdn.com/image/hardfork?filter_last=1&fit=1280%2C640&url=https%3A%2F%2Fcdn0.tnwcdn.com%2Fwp-content%2Fblogs.dir%2F1%2Ffiles%2F2019%2F08%2Fbitcoin_today-header_bitcoin_today.jpg&signature=30221b6a68049cc6bc3b58f3ddb38864",
                "publishedAt": "2019-11-08T11:25:26Z",
                "content": "Our robot colleague Satoshi Nakaboto writes about Bitcoin BTC every fucking day.\\nWelcome to another edition of Bitcoin Today, where I, Satoshi Nakaboto, tell you whats been going on with Bitcoin in the past 24 hours. As Isaac Newton used to say: The long and… [+2687 chars]"
            },
            {
                "source": {
                    "id": "the-next-web",
                    "name": "The Next Web"
                },
                "author": "Yessi Bello Perez",
                "title": "Twitter CEO Jack Dorsey attends Bitcoin meetup in Ghana",
                "description": "Twitter and Square CEO Jack Dorsey has attended a Bitcoin meetup in Ghana just weeks after he invested in a cryptocurrency startup. Dorsey, who has long defended Bitcoin, has been traveling in Africa, and has so far visited Nigeria and Ghana. Mini bitcoin Gha…",
                "url": "https://thenextweb.com/hardfork/2019/11/12/twitter-ceo-jack-dorsey-attends-bitcoin-meetup-in-ghana/",
                "urlToImage": "https://img-cdn.tnwcdn.com/image/hardfork?filter_last=1&fit=1280%2C640&url=https%3A%2F%2Fcdn0.tnwcdn.com%2Fwp-content%2Fblogs.dir%2F1%2Ffiles%2F2019%2F11%2Fcryptocurrency-bitcoin-jack-dorsey.jpg&signature=4ea6f6c41bf795c32ad52a84c836b9f3",
                "publishedAt": "2019-11-12T15:57:32Z",
                "content": "Twitter and Square CEO Jack Dorsey has attended a Bitcoin meetup in Ghana just weeks after he invested in a cryptocurrency startup.\\nDorsey, who has long defended Bitcoin, has been traveling in Africa, and has so far visited Nigeria and Ghana.\\nMini bitcoin G… [+1911 chars]"
            },
            {
                "source": {
                    "id": "the-next-web",
                    "name": "The Next Web"
                },
                "author": "Satoshi Nakaboto",
                "title": "Satoshi Nakaboto: ‘Bitcoin rewards app Lolli among 100 most promising startups’",
                "description": "Our robot colleague Satoshi Nakaboto writes about Bitcoin every fucking day. Welcome to another edition of Bitcoin Today, where I, Satoshi Nakaboto, tell you what’s been going on with Bitcoin in the past 24 hours. As Hegel used to say: Let’s make it rock! Bit…",
                "url": "https://thenextweb.com/hardfork/2019/11/14/satoshi-nakaboto-bitcoin-rewards-app-lolli-among-100-most-promising-startups/",
                "urlToImage": "https://img-cdn.tnwcdn.com/image/hardfork?filter_last=1&fit=1280%2C640&url=https%3A%2F%2Fcdn0.tnwcdn.com%2Fwp-content%2Fblogs.dir%2F1%2Ffiles%2F2019%2F08%2Fbitcoin_today-header_bitcoin_today.jpg&signature=30221b6a68049cc6bc3b58f3ddb38864",
                "publishedAt": "2019-11-14T09:51:04Z",
                "content": "Our robot colleague Satoshi Nakaboto writes about Bitcoin BTC every fucking day.\\nWelcome to another edition of Bitcoin Today, where I, Satoshi Nakaboto, tell you whats been going on with Bitcoin in the past 24 hours. As Hegel used to say: Lets make it rock!\\n… [+2694 chars]"
            },
            {
                "source": {
                    "id": "the-next-web",
                    "name": "The Next Web"
                },
                "author": "Satoshi Nakaboto",
                "title": "Satoshi Nakaboto: ‘200 Bitcoin devs assess new privacy and scaling upgrades’",
                "description": "Our robot colleague Satoshi Nakaboto writes about Bitcoin every fucking day. Welcome to another edition of Bitcoin Today, where I, Satoshi Nakaboto, tell you what’s been going on with Bitcoin in the past 24 hours. As Sloterdijk used to say: Bob’s your uncle! …",
                "url": "https://thenextweb.com/hardfork/2019/11/18/satoshi-nakaboto-200-bitcoin-devs-assess-new-privacy-and-scaling-upgrades/",
                "urlToImage": "https://img-cdn.tnwcdn.com/image/hardfork?filter_last=1&fit=1280%2C640&url=https%3A%2F%2Fcdn0.tnwcdn.com%2Fwp-content%2Fblogs.dir%2F1%2Ffiles%2F2019%2F08%2Fbitcoin_today-header_bitcoin_today.jpg&signature=30221b6a68049cc6bc3b58f3ddb38864",
                "publishedAt": "2019-11-18T10:56:59Z",
                "content": "Our robot colleague Satoshi Nakaboto writes about Bitcoin BTC every fucking day.\\nWelcome to another edition of Bitcoin Today, where I, Satoshi Nakaboto, tell you whats been going on with Bitcoin in the past 24 hours. As Sloterdijk used to say: Bobs your uncl… [+2682 chars]"
            },
            {
                "source": {
                    "id": null,
                    "name": "Entrepreneur.com"
                },
                "author": "Daniel Priestley",
                "title": "10 Business Trends That Defined the 2010s",
                "description": "From the rise of bitcoin to women taking the reins, a look back at the decade that was.",
                "url": "https://www.entrepreneur.com/article/341938",
                "urlToImage": "https://assets.entrepreneur.com/content/3x2/2000/20191106203434-GettyImages-691047369.jpeg",
                "publishedAt": "2019-11-08T17:00:00Z",
                "content": "November\\n8, 2019\\n6 min read\\nOpinions expressed by Entrepreneur contributors are their own.\\nAs this decade draws to a close, it’s natural to look ahead and wonder what the future holds. However, it’s also worth looking back to see how much things have chan… [+6287 chars]"
            },
            {
                "source": {
                    "id": "the-next-web",
                    "name": "The Next Web"
                },
                "author": "Satoshi Nakaboto",
                "title": "Satoshi Nakaboto: ‘$500k lottery winner invests half of his winnings in Bitcoin’",
                "description": "Our robot colleague Satoshi Nakaboto writes about Bitcoin every fucking day. Welcome to another edition of Bitcoin Today, where I, Satoshi Nakaboto, tell you what’s been going on with Bitcoin in the past 24 hours. As Kierkegaard used to say: If you love yours…",
                "url": "https://thenextweb.com/hardfork/2019/11/06/satoshi-nakaboto-500k-lottery-winner-invests-half-of-his-winnings-in-bitcoin/",
                "urlToImage": "https://img-cdn.tnwcdn.com/image/hardfork?filter_last=1&fit=1280%2C640&url=https%3A%2F%2Fcdn0.tnwcdn.com%2Fwp-content%2Fblogs.dir%2F1%2Ffiles%2F2019%2F08%2Fbitcoin_today-header_bitcoin_today.jpg&signature=30221b6a68049cc6bc3b58f3ddb38864",
                "publishedAt": "2019-11-06T10:03:53Z",
                "content": "Our robot colleague Satoshi Nakaboto writes about Bitcoin BTC every fucking day.\\nWelcome to another edition of Bitcoin Today, where I, Satoshi Nakaboto, tell you whats been going on with Bitcoin in the past 24 hours. As Kierkegaard used to say: If you love y… [+2998 chars]"
            },
            {
                "source": {
                    "id": "the-next-web",
                    "name": "The Next Web"
                },
                "author": "Satoshi Nakaboto",
                "title": "Satoshi Nakaboto: ‘Bitcoin market cap rivals China Mobile, China’s largest wireless carrier’",
                "description": "Our robot colleague Satoshi Nakaboto writes about Bitcoin every fucking day. Welcome to another edition of Bitcoin Today, where I, Satoshi Nakaboto, tell you what’s been going on with Bitcoin in the past 24 hours. As Jane Didion used to say: Let’s whip up a k…",
                "url": "https://thenextweb.com/hardfork/2019/11/02/satoshi-nakaboto-bitcoin-market-cap-rivals-china-mobile-chinas-largest-wireless-carrier/",
                "urlToImage": "https://img-cdn.tnwcdn.com/image/hardfork?filter_last=1&fit=1280%2C640&url=https%3A%2F%2Fcdn0.tnwcdn.com%2Fwp-content%2Fblogs.dir%2F1%2Ffiles%2F2019%2F08%2Fbitcoin_today-header_bitcoin_today.jpg&signature=30221b6a68049cc6bc3b58f3ddb38864",
                "publishedAt": "2019-11-02T10:16:03Z",
                "content": "Our robot colleague Satoshi Nakaboto writes about Bitcoin BTC every fucking day.\\nWelcome to another edition of Bitcoin Today, where I, Satoshi Nakaboto, tell you whats been going on with Bitcoin in the past 24 hours. As Jane Didion used to say: Lets whip up … [+2898 chars]"
            },
            {
                "source": {
                    "id": "the-next-web",
                    "name": "The Next Web"
                },
                "author": "Satoshi Nakaboto",
                "title": "Satoshi Nakaboto: ‘Bitcoin’s median transaction fee hits 8-month low’",
                "description": "Our robot colleague Satoshi Nakaboto writes about Bitcoin every fucking day. Welcome to another edition of Bitcoin Today, where I, Satoshi Nakaboto, tell you what’s been going on with Bitcoin in the past 24 hours. As Planck used to say: Yolo! Bitcoin Price We…",
                "url": "https://thenextweb.com/hardfork/2019/10/22/satoshi-nakaboto-bitcoins-median-transaction-fee-hits-8-month-low/",
                "urlToImage": "https://img-cdn.tnwcdn.com/image/hardfork?filter_last=1&fit=1280%2C640&url=https%3A%2F%2Fcdn0.tnwcdn.com%2Fwp-content%2Fblogs.dir%2F1%2Ffiles%2F2019%2F08%2Fbitcoin_today-header_bitcoin_today.jpg&signature=30221b6a68049cc6bc3b58f3ddb38864",
                "publishedAt": "2019-10-22T09:47:00Z",
                "content": "Our robot colleague Satoshi Nakaboto writes about Bitcoin BTC every fucking day.\\nWelcome to another edition of Bitcoin Today, where I, Satoshi Nakaboto, tell you whats been going on with Bitcoin in the past 24 hours. As Planck used to say: Yolo!\\nBitcoin Pri… [+2953 chars]"
            },
            {
                "source": {
                    "id": "the-next-web",
                    "name": "The Next Web"
                },
                "author": "Satoshi Nakaboto",
                "title": "Satoshi Nakaboto: ‘Bitcoin dips below $8K for 7th time in a month’",
                "description": "Our robot colleague Satoshi Nakaboto writes about Bitcoin every fucking day. Welcome to another edition of Bitcoin Today, where I, Satoshi Nakaboto, tell you what’s been going on with Bitcoin in the past 24 hours. As Bentham used to say: Your imagination is t…",
                "url": "https://thenextweb.com/hardfork/2019/10/23/satoshi-nakaboto-bitcoin-dips-below-8k-for-7th-time-in-a-month/",
                "urlToImage": "https://img-cdn.tnwcdn.com/image/hardfork?filter_last=1&fit=1280%2C640&url=https%3A%2F%2Fcdn0.tnwcdn.com%2Fwp-content%2Fblogs.dir%2F1%2Ffiles%2F2019%2F08%2Fbitcoin_today-header_bitcoin_today.jpg&signature=30221b6a68049cc6bc3b58f3ddb38864",
                "publishedAt": "2019-10-23T10:02:33Z",
                "content": "Our robot colleague Satoshi Nakaboto writes about Bitcoin BTC every fucking day.\\nWelcome to another edition of Bitcoin Today, where I, Satoshi Nakaboto, tell you whats been going on with Bitcoin in the past 24 hours. As Bentham used to say: Your imagination … [+2708 chars]"
            },
            {
                "source": {
                    "id": "the-next-web",
                    "name": "The Next Web"
                },
                "author": "Satoshi Nakaboto",
                "title": "Satoshi Nakaboto: ‘Bitcoin consolidates just above $9,000’",
                "description": "Our robot colleague Satoshi Nakaboto writes about Bitcoin every fucking day. Welcome to another edition of Bitcoin Today, where I, Satoshi Nakaboto, tell you what’s been going on with Bitcoin in the past 24 hours. As Descartes used to say: Do what you love an…",
                "url": "https://thenextweb.com/hardfork/2019/11/01/satoshi-nakaboto-bitcoin-consolidates-just-above-9000/",
                "urlToImage": "https://img-cdn.tnwcdn.com/image/hardfork?filter_last=1&fit=1280%2C640&url=https%3A%2F%2Fcdn0.tnwcdn.com%2Fwp-content%2Fblogs.dir%2F1%2Ffiles%2F2019%2F08%2Fbitcoin_today-header_bitcoin_today.jpg&signature=30221b6a68049cc6bc3b58f3ddb38864",
                "publishedAt": "2019-11-01T09:47:34Z",
                "content": "Our robot colleague Satoshi Nakaboto writes about Bitcoin BTC every fucking day.\\nWelcome to another edition of Bitcoin Today, where I, Satoshi Nakaboto, tell you whats been going on with Bitcoin in the past 24 hours. As Descartes used to say: Do what you lov… [+3001 chars]"
            },
            {
                "source": {
                    "id": "the-next-web",
                    "name": "The Next Web"
                },
                "author": "Satoshi Nakaboto",
                "title": "Satoshi Nakaboto: ‘HTC’s latest phone can run a full Bitcoin node’",
                "description": "Our robot colleague Satoshi Nakaboto writes about Bitcoin every fucking day. Welcome to another edition of Bitcoin Today, where I, Satoshi Nakaboto, tell you what’s been going on with Bitcoin in the past 24 hours. As Faraday used to say: Talk to a stranger on…",
                "url": "https://thenextweb.com/hardfork/2019/10/20/satoshi-nakaboto-htcs-latest-phone-can-run-a-full-bitcoin-node/",
                "urlToImage": "https://img-cdn.tnwcdn.com/image/hardfork?filter_last=1&fit=1280%2C640&url=https%3A%2F%2Fcdn0.tnwcdn.com%2Fwp-content%2Fblogs.dir%2F1%2Ffiles%2F2019%2F08%2Fbitcoin_today-header_bitcoin_today.jpg&signature=30221b6a68049cc6bc3b58f3ddb38864",
                "publishedAt": "2019-10-20T10:59:59Z",
                "content": "Our robot colleague Satoshi Nakaboto writes about Bitcoin BTC every fucking day.\\nWelcome to another edition of Bitcoin Today, where I, Satoshi Nakaboto, tell you whats been going on with Bitcoin in the past 24 hours. As Faraday used to say: Talk to a strange… [+2945 chars]"
            },
            {
                "source": {
                    "id": "the-next-web",
                    "name": "The Next Web"
                },
                "author": "Satoshi Nakaboto",
                "title": "Satoshi Nakaboto: ‘Republican congressman says Facebook should embrace Bitcoin and drop Libra’",
                "description": "Our robot colleague Satoshi Nakaboto writes about Bitcoin every fucking day. Welcome to another edition of Bitcoin Today, where I, Satoshi Nakaboto, tell you what’s been going on with Bitcoin in the past 24 hours. As Schopenhauer used to say: Yolo! Bitcoin Pr…",
                "url": "https://thenextweb.com/hardfork/2019/10/18/satoshi-nakaboto-republican-congressman-says-facebook-should-embrace-bitcoin-and-drop-libra/",
                "urlToImage": "https://img-cdn.tnwcdn.com/image/hardfork?filter_last=1&fit=1280%2C640&url=https%3A%2F%2Fcdn0.tnwcdn.com%2Fwp-content%2Fblogs.dir%2F1%2Ffiles%2F2019%2F08%2Fbitcoin_today-header_bitcoin_today.jpg&signature=30221b6a68049cc6bc3b58f3ddb38864",
                "publishedAt": "2019-10-18T09:44:40Z",
                "content": "Our robot colleague Satoshi Nakaboto writes about Bitcoin BTC every fucking day.\\nWelcome to another edition of Bitcoin Today, where I, Satoshi Nakaboto, tell you whats been going on with Bitcoin in the past 24 hours. As Schopenhauer used to say: Yolo!\\nBitco… [+2872 chars]"
            }
        ]
    }
    """
